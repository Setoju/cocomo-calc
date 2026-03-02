class CocomoController < ApplicationController
  MODES = {
    "organic" => { a: 2.4,  b: 1.05, c: 2.5, d: 0.38, label: "Organic", description: "Small teams, familiar domain" },
    "semi_detached" => { a: 3.0,  b: 1.12, c: 2.5, d: 0.35, label: "Semi-detached", description: "Medium teams, mixed experience" },
    "embedded" => { a: 3.6,  b: 1.20, c: 2.5, d: 0.32, label: "Embedded", description: "Tight constraints, complex requirements" }
  }.freeze

  def index
  end

  def calculate
    kloc = params[:kloc].to_f
    @results = {}

    if kloc > 0
      MODES.each do |key, config|
        effort = config[:a] * (kloc ** config[:b])
        duration = config[:c] * (effort ** config[:d])
        team = effort / duration
        productivity = kloc / effort

        @results[key] = {
          label: config[:label],
          description: config[:description],
          effort: effort.round(2),
          duration: duration.round(2),
          team: team.round(2),
          productivity: productivity.round(3)
        }
      end
    end

    @kloc = kloc

    respond_to do |format|
      format.turbo_stream
    end
  end
end
