module RedmineClient
  class Issue < RedmineClient::Base
    class Status < RedmineClient::Base
    end
    class Tracker < RedmineClient::Base
    end
    class AssignedTo < RedmineClient::Base
    end
    class Parent < RedmineClient::Base
    end
    class Author < RedmineClient::Base
    end
    class Priority < RedmineClient::Base
    end
    class FixedVersion < RedmineClient::Base
    end
  end
end
