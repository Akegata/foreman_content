module Content
  module Api
    class RepositoriesController < ::Api::V2::BaseController

      before_filter :validate_access_to_events, :only => :events
      skip_before_filter :authorize, :only => :events

      # callback event from pulp upon tasks/events finished up
      def events
        repo_id = params['payload']['repo_id'] if params['payload']
        render_error 'not_found', :status => :not_found and return false if repo_id.blank?
        Content::Pulp::EventHandler.new(repo_id, params)
        head :status => 202
      end

      private

      def validate_access_to_events
        #validate our pulp server here
        # we really want to use existing smart proxy infrastructure to do this.
        true
      end
    end
  end
end
