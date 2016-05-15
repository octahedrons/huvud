# See Heroku Labs: Dyno Metadata for more information
# https://devcenter.heroku.com/articles/dyno-metadata

module AppMetadata
  module_function

  def app_name
    ENV.fetch("HEROKU_APP_NAME") { "huvud-dev" }
  end

  def commit
    ENV.fetch("HEROKU_SLUG_COMMIT") { "bad0a554069af49b3de35b8e8c26765c1dba9ff02" }
  end

  def short_commit
    commit[0, 7]
  end

  def short_commit_link
    "<a href='https://github.com/dentarg/huvud/commit/#{commit}'>#{short_commit}</a>"
  end
end
