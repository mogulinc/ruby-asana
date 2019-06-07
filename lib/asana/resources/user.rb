### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.

module Asana
  module Resources
    # A _user_ object represents an account in Asana that can be given access to
    # various workspaces, projects, and tasks.
    #
    # Like other objects in the system, users are referred to by numerical IDs.
    # However, the special string identifier `me` can be used anywhere
    # a user ID is accepted, to refer to the current authenticated user.
    class User < Resource


      attr_reader :id

      attr_reader :name

      attr_reader :email

      attr_reader :photo

      attr_reader :workspaces

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'users'
        end

        # Returns the full user record for the currently authenticated user.
        #
        # options - [Hash] the request I/O options.
        def me(client, options: {})

          Resource.new(parse(client.get("/users/me", options: options)).first, client: client)
        end

        # Returns the full user record for the single user with the provided ID.
        #
        # id - [String] An identifier for the user. Can be one of an email address,
        # the globally unique identifier for the user, or the keyword `me`
        # to indicate the current user making the request.
        #
        # options - [Hash] the request I/O options.
        def find_by_id(client, id, options: {})

          self.new(parse(client.get("/users/#{id}", options: options)).first, client: client)
        end

        # Returns the user records for all users in the specified workspace or
        # organization.
        #
        # workspace - [Id] The workspace in which to get users.
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_by_workspace(client, workspace: required("workspace"), per_page: 20, options: {})
          params = { limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/workspaces/#{workspace}/users", params: params, options: options)), type: self, client: client)
        end

        # Returns the user records for all users in all workspaces and organizations
        # accessible to the authenticated user. Accepts an optional workspace ID
        # parameter.
        #
        # workspace - [Id] The workspace or organization to filter users on.
        # per_page - [Integer] the number of records to fetch per page.
        # options - [Hash] the request I/O options.
        def find_all(client, workspace: nil, per_page: 20, options: {})
          params = { workspace: workspace, limit: per_page }.reject { |_,v| v.nil? || Array(v).empty? }
          Collection.new(parse(client.get("/users", params: params, options: options)), type: self, client: client)
        end

        def user_task_list(client, id, workspace_id, options: {})
          Resource.new(parse(client.get("/users/#{id}/user_task_list", params: { workspace: workspace_id }, options: options)).first, client: client)
        end

        def user_task_list_tasks(client, user_task_list_id, completed_since: nil, options: {})
          params = {}
          if completed_since
            params[:completed_since] = completed_since
          end

          Resource.new(parse(client.get("/user_task_lists/#{user_task_list_id}/tasks", params: params, options: options)).first, client: client)
        end
      end

    end
  end
end
