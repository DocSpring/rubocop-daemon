# frozen_string_literal: true

module RuboCop
  module Daemon
    module ServerCommand
      class Base
        module Runner
          def run
            validate_token!
            Dir.chdir(@cwd) do
              super
            end
          end
        end

        def self.inherited(child)
          child.prepend Runner
        end

        def initialize(args, token: '', cwd: Dir.pwd)
          @args = args
          @token = token
          @cwd = cwd
        end

        def run; end

        private

        def validate_token!
          raise InvalidTokenError unless Cache.token_path.read == @token
        end
      end
    end
  end
end
