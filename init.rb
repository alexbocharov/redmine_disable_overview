require 'redmine'

Redmine::Plugin.register :redmine_disable_overview do
  name 'Disable overview'
  author 'Alexander Bocharov'
  description 'This plugin disables project overview'
  version '0.1.0'
  url 'https://github.com/alexbocharov/redmine_disable_overview.git'

  requires_redmine :version_or_higher => '3.4'

  project_module :redmine_disable_overview do |map|
    map.permission :overview_permission, {:projects => :show}
  end

  ActionDispatch::Callbacks.to_prepare do
    require_dependency 'application_controller'
    require_dependency 'redmine/access_control'

    require_dependency 'projects_controller'
    require_dependency 'reports_controller'

    ProjectsController.class_eval do
      def verify_module_activated
        if !User.current.admin? && @project && @project.module_enabled?("redmine_disable_overview")
          redirect_to :controller => 'issues', :action => 'index',  :project_id => @project
          Redmine::MenuManager.map :project_menu do |menu|
            menu.delete(:overview) 
          end
        else
          Redmine::MenuManager.map :project_menu do |menu|
            if !menu.exists?(:overview)
              menu.push :overview, { :controller => 'projects', :action => 'show' }, :after => :new_object
            end
          end
        end
      end

      before_filter :verify_module_activated
      private :verify_module_activated
    end

    ReportsController.class_eval do
      def verify_module_activated
        if !User.current.admin?
          render_403 if @project && @project.module_enabled?("redmine_disable_overview")
        end
      end

      before_filter :verify_module_activated
      private :verify_module_activated
    end
  end
end