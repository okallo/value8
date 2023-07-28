defmodule EmailsAppWeb.Group_UserHTML do
  use EmailsAppWeb, :html

  embed_templates "group__user_html/*"

  @doc """
  Renders a group__user form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def group__user_form(assigns)
end
