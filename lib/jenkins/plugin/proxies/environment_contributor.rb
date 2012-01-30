require 'jenkins/model/environment_contributor'

module Jenkins
  class Plugin
    class Proxies
      class EnvironmentContributorProxy < Java.hudson.model.EnvironmentContributor
        include Jenkins::Plugin::Proxy

        def buildEnvironmentFor(run,envs,listener)
          @object.build_environment_for(import(run), envs, import(listener))
        end
      end
      register Jenkins::Model::EnvironmentContributor, EnvironmentContributorProxy
    end
  end
end