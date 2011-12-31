module Jenkins
  module Model
    class EnvironmentContributor
      include ExtensionPoint
      when_implemented :register

      # public abstract void buildEnvironmentFor(Run r, EnvVars envs, TaskListener listener) throws IOException, InterruptedException;

      ##
      # Contributes environment variables used for a build.
      #
      # @param [Jenkins::Model::Build] run
      #         Build that's being performed. Never null.
      # @param [Java.hudson.EnvVars] env
      #         Partially built environment variable map. Implementation of this method is expected to
      #         add additional variables here. Never null.
      # @param [Jenkins::Model::Listener] listener
      #         Connected to the build console. Can be used to report errors. Never null.
      def build_environment_for(run,env,listener)
      end
    end
  end
end