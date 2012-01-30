module Jenkins
  module Model
    module Listeners
      class RunListener
        include ExtensionPoint
        when_implemented :register

        def on_completed(run,listener)
        end

        def on_finalized(run)
        end

        def on_started(run,listener)
        end

        # not yet wrapped
        #def setup_environment(build,launcher,listener)
        #end

        def on_deleted(run)
        end
      end
    end
  end
end