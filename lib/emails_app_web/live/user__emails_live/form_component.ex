defmodule EmailsAppWeb.User_EmailsLive.FormComponent do
  use EmailsAppWeb, :live_component

  alias EmailsApp.MyEmail
  alias EmailsApp.Accounts.UserNotifier

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
      </.header>

      <.simple_form
        for={@form}
        id="user__emails-form"
        phx-target={@myself}
        phx-submit="save"
        phx-change="validate"
      >
        <.input field={@form[:to_user]} type="text" label="To" />
        <.input
          field={@form[:from_user]}
          type="hidden"
          value={@content}
          readonly
          class="invisible"
        />
        <.input field={@form[:subject]} type="text" label="Subject" />
        <.input type="text" field={@form[:content]} label="Content" />
        <:actions>
          <.button phx-disable-with="Saving...">Send Email</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{user__emails: user__emails} = assigns, socket) do
    changeset = MyEmail.change_user__emails(user__emails)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"user__emails" => user__emails_params}, socket) do
    changeset =
      socket.assigns.user__emails
      |> MyEmail.change_user__emails(user__emails_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"user__emails" => emails_params}, socket) do
   
    case UserNotifier.send_email(emails_params) do
      {:ok, _email} ->
        params_with_status = Map.put(emails_params, "status", "sent")
        save_user__emails(socket, :new, params_with_status)

      {:error, _reason} ->
        params_with_status = Map.put(emails_params, "status", "not_sent")
        save_user__emails(socket, :new, params_with_status)
    end
  end


  defp save_user__emails(socket, :edit, user__emails_params) do
    case MyEmail.update_user__emails(socket.assigns.user__emails, user__emails_params) do
      {:ok, user__emails} ->
        notify_parent({:saved, user__emails})

        {:noreply,
         socket
         |> put_flash(:info, "User  emails updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_user__emails(socket, :new, user__emails_params) do
    case MyEmail.create_user__emails(user__emails_params) do
      {:ok, user__emails} ->
        notify_parent({:saved, user__emails})

        {:noreply,
         socket
         |> put_flash(:info, "User  emails created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
