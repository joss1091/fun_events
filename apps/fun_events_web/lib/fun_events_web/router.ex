defmodule FunEventsWeb.Router do
  use FunEventsWeb, :router

  import FunEventsWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FunEventsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", FunEventsWeb do
  #   pipe_through :browser

  #   get "/", PageController, :home
  # end

  # Other scopes may use custom stacks.
  # scope "/api", FunEventsWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:fun_events_web, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FunEventsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", FunEventsWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{FunEventsWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/", UserLoginLive, :new
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", FunEventsWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{FunEventsWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email


      live "/events", EventLive.Index, :index
      live "/events/new", EventLive.Index, :new
      live "/events/:id/edit", EventLive.Index, :edit

      live "/events/:id", EventLive.Show, :show
      live "/events/:id/show/edit", EventLive.Show, :edit

      live "/guests", GuestLive.Index, :index
      live "/guests/new", GuestLive.Index, :new
      live "/guests/:id/edit", GuestLive.Index, :edit

      live "/guests/:id", GuestLive.Show, :show
      live "/guests/:id/show/edit", GuestLive.Show, :edit

      live "/notification", NotificationLoggerLive.Index, :index
      live "/notification/new", NotificationLoggerLive.Index, :new
      live "/notification/:id/edit", NotificationLoggerLive.Index, :edit

      live "/notification/:id", NotificationLoggerLive.Show, :show
      live "/notification/:id/show/edit", NotificationLoggerLive.Show, :edit

      live "/guest_notification_configs", GuesNotificationConfigLive.Index, :index
      live "/guest_notification_configs/new", GuesNotificationConfigLive.Index, :new
      live "/guest_notification_configs/:id/edit", GuesNotificationConfigLive.Index, :edit

      live "/guest_notification_configs/:id", GuesNotificationConfigLive.Show, :show
      live "/guest_notification_configs/:id/show/edit", GuesNotificationConfigLive.Show, :edit

      live "/parameters", ParameterLive.Index, :index
      live "/parameters/new", ParameterLive.Index, :new
      live "/parameters/:id/edit", ParameterLive.Index, :edit

      live "/parameters/:id", ParameterLive.Show, :show
      live "/parameters/:id/show/edit", ParameterLive.Show, :edit
    end
  end

  scope "/", FunEventsWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{FunEventsWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
