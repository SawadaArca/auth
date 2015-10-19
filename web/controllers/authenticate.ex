defmodule Auth.Authenticate do
  import Plug.Conn

  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be login to access that page.")
      |> redirect(to: Auth.Router.Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end