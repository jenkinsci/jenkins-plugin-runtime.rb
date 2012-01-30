require 'jenkins/model/listeners/run_listener'

module Jenkins
  class Plugin
    class Proxies
      class RunListenerProxy < Java.hudson.model.listeners.RunListener
        include Jenkins::Plugin::Proxy

        def onCompleted(run,listener)
          @object.on_completed(import(run),import(listener))
        end

        def onFinalized(run)
          @object.on_finalized(import(run))
        end

        def onStarted(run)
          @object.on_started(import(run),import(listener))
        end

        # TODO: think about how to wrap this
        #def setupEnvironment(build,launcher,listener)
        #  @object.setup(import(build), import(launcher), import(listener))
        #  EnvironmentWrapper.new(self, @plugin, self)
        #end

        def teardown(build,listener)
        end
      end
      register Jenkins::Model::Listeners::RunListener, RunListenerProxy
    end
  end
end