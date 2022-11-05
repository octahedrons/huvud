# frozen_string_literal: true

# https://github.com/dentarg/fly/commit/b8685c570ea849367f1a719121bcba0bf6645b3f
module AppMetadata
  module_function

  def app_name
    ENV.fetch("FLY_APP_NAME") { "huvud-dev" }
  end

  def commit
    ENV.fetch("RELEASE_COMMIT") { "bad0a554069af49b3de35b8e8c26765c1dba9ff02" }
  end

  def short_commit
    commit[0, 7]
  end

  def short_commit_link
    "<a href='https://github.com/dentarg/huvud/commit/#{commit}'>#{short_commit}</a>"
  end
end
