defmodule EmailsAppWeb.Router do
  use EmailsAppWeb, :router

  import EmailsAppWeb.UserAuth
  # import EmailsAppWeb.EnsureRolePlug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {EmailsAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  # pipeline :superuser do
  #   plug EnsureRolePlug, [:superuser]
  # end

  # pipeline :admin do
  #   plug EnsureRolePlug, [:admin, :superuser]
  # end

  # pipeline :user do
  #   plug EnsureRolePlug, [:admin, :superuser, :user, :gold]
  # end

  # pipeline :gold do
  #   plug EnsureRolePlug, [:admin, :superuser, :gold]
  # end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EmailsAppWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", EmailsAppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:emails_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: EmailsAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", EmailsAppWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{EmailsAppWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", EmailsAppWeb do
    pipe_through [:browser, :require_authenticated_user]
    #pipe_through [:browser, :require_authenticated_agent, :user]

    live_session :require_authenticated_user,
      on_mount: [{EmailsAppWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", EmailsAppWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{EmailsAppWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
      live "/users", UserLive.Index, :index

      live "/contact", ContactsLive.Index, :index
      live "/contact/new", ContactsLive.Index, :new
      live "/contact/:id/edit", ContactsLive.Index, :edit
      live "/contact/:id", ContactsLive.Show, :show
      live "/contact/:id/show/edit", ContactsLive.Show, :edit

      live "/group", GroupsLive.Index, :index
      live "/group/new", GroupsLive.Index, :new
      live "/group/:id/edit", GroupsLive.Index, :edit
      live "/group/:id", GroupsLive.Show, :show
      live "/group/:id/show/edit", GroupsLive.Show, :edit

      live "/group_user", Group_usersLive.Index, :index
      live "/group_user/new", Group_usersLive.Index, :new
      live "/group_user/:id/edit", Group_usersLive.Index, :edit
      live "/group_user/:id", Group_usersLive.Show, :show
      live "/group_user/:id/show/edit", Group_usersLive.Show, :edit

      live "/user_email", User_EmailsLive.Index, :index
      live "/user_email/sent", User_EmailsLive.Sent, :sent
      live "/user_email/outbox", User_EmailsLive.Failed, :failed
      live "/user_email/new", User_EmailsLive.Index, :new
      live "/user_email/:id/edit", User_EmailsLive.Index, :edit
      live "/user_email/:id", User_EmailsLive.Show, :show
      live "/user_email/:id/show/edit", User_EmailsLive.Show, :edit
    end
  end
end
