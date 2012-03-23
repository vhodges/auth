module Trinidad
  module Lifecycle
    module WebApp
      class TermHostConnectionListener
        include Trinidad::Tomcat::LifecycleListener

        def lifecycleEvent(event)
          if Trinidad::Tomcat::Lifecycle::BEFORE_STOP_EVENT == event.type
            # do something before stopping the web application context
            FinancialInstitutionConfig.shutdown_corebanking_auth_client
          end
        end

      end
    end
  end
end
