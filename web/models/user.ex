defmodule Auth.User do
  use Auth.Web, :model

  schema "users" do
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps
  end

  # @required_fields ~w(username password)
  # @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(username), [])
    |> validate_length(:username, min: 3, max: 20)
    
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ -> 
        changeset  
    end
  end


end
