module Jenkins
  # Enables detection of subtypes
  #
  # By including this module and specifying the ''when_implemented' callback,
  # the class becomes capable of detecting subtypes as they are defined.
  #
  # e.g.,
  # class Foo
  #   include ExtensionPoint
  #   when_implemented do |cls|
  #     puts "Foo is subtyped by #{cls}'
  #   end
  # end
  #
  # class Bar < Foo
  # end
  # # the line above will print "Foo is subtyped by Bar"
  #
  # class Zot < Bar
  # end
  # # the line above will print "Foo is subtyped by Zot"
  module ExtensionPoint
    module Inherited
      def inherited(cls)
        super(cls)
        cls.extend Inherited
        origin = @origin
        cls.class_eval do
          @origin = origin
        end
        #if Jenkins::Plugin.instance
        #  Jenkins::Plugin.instance.peer.addExtension(cls)
        #end
        (@origin.when_implemented||proc{}).call(cls)
      end
    end

    module Included
      def included(mod)
        super(mod)
        if mod.is_a? Class
          mod.extend Inherited
          mod.class_eval do
            # specify the callback to run whenevr a new type is defined extending Foo (the type that included ExtensionPoint)
            # either a callback or a symbol
            def self.when_implemented(behavior = nil, &block)
              if block || behavior
                if behavior==:register then
                  # allow the caller to specify this very common behavior
                  # (of instantiating an extension, wrapping it into the wrapper and registering it)
                  # as a symbol
                  block = proc do |cls|
                    Plugin.instance.post_init do
                      Plugin.instance.peer.addExtension(Plugin.instance.export(cls.new))
                    end
                  end
                end

                @when_implemented = block
              else
                @when_implemented
              end
            end

            @origin = self
          end
        else
          warn "tried to include ExtensionPoint into a Module. Are you sure?"
        end
      end
    end

    self.extend Included
  end
end