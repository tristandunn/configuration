#!/usr/bin/env ruby

# frozen_string_literal: true

class Old
  UPGRADE_ARGUMENTS = %w(up update upgrade).freeze

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
    casks  = outdated_casks == 1 ? "cask" : "casks"
    leaves = outdated_leaves == 1 ? "leaf" : "leaves"

    puts("\nYou have " \
         "#{bold(outdated_leaves)} old #{leaves} and " \
         "#{bold(outdated_casks)} old #{casks}.\n\n")

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

  def outdated_casks
    (outdated & casks).size
  end

  def outdated_leaves
    ((upgrades + reinstalls) - casks).size
  end

  def reinstalls
    @reinstalls ||= (uses & leaves) - upgrades
  end

  def uninstalls
    @uninstalls ||= (dependencies - leaves - upgrades)
  end

  def update
    puts("brew uninstall --ignore-dependencies #{uninstalls.join(" ")}") if uninstalls.any?
    puts("brew upgrade #{upgrades.join(" ")}") if upgrades.any?
    puts("brew reinstall #{reinstalls.join(" ")}") if reinstalls.any?
  end

  def update?
    UPGRADE_ARGUMENTS.include?(ARGV.first)
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
