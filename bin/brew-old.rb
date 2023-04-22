#!/usr/bin/env ruby

class Old
  def initialize(command)
    @command = command
  end

  def self.run
    new(ARGV.first).run
  end

  def run
    if update?
      update
    else
      information
    end
  end

  private

  attr_reader :command

  def bold(text)
    "\033[1m#{text}\033[0m"
  end

  def brew(command)
    `brew #{command}`.split("\n").sort
  end

  def casks
    @casks ||= brew("list --cask")
  end

  def dependencies
    @dependencies ||= (outdated - upgrades)
  end

  def information
    outdated_casks  = (outdated & casks).size
    outdated_leaves = ((upgrades + reinstalls) - casks).size

    puts("\nYou have " \
         "#{bold(outdated_leaves)} old leaves and " \
         "#{bold(outdated_casks)} old casks.\n\n")

    (upgrades + reinstalls).sort.each do |formulae|
      puts formulae
    end
  end

  def installed
    @installed ||= (casks + leaves).sort
  end

  def leaves
    @leaves ||= brew("leaves")
  end

  def outdated
    @outdated ||= brew("outdated")
  end

  def reinstalls
    @reinstalls ||= (uses & leaves)
  end

  def update
    puts("brew upgrade #{upgrades.join(" ")}")
    puts("brew reinstall #{reinstalls.join(" ")}")
  end

  def update?
    ARGV.first == "update"
  end

  def upgrades
    @upgrades ||= (installed & outdated)
  end

  def uses
    @uses ||= dependencies.flat_map do |formula|
      brew("uses --installed #{formula}")
    end
  end
end

Old.run
