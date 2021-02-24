defmodule Rocketpay.User.Create do
  alias Rocketpay.{Account, User, Repo}

  alias Ecto.Multi

  def call(params) do
    # Inserção de mais de um Model
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_account, fn repo, %{create_user: user} ->
      insert_account(repo, user.id)
    end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} ->
      preload_data(repo, user)
    end)
    |> run_transaction()

    # Inserção de apenas um Model
    # params
    # |> User.changeset()
    # |> Repo.insert()
  end

  defp insert_account(repo, user_id) do
    user_id
    |> account_changeset()
    |> repo.insert()
  end

  defp preload_data(repo, user) do
    {:ok, repo.preload(user, :account)}
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, balance: "0.00"}

    Account.changeset(params)
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{preload_data: user}} ->
        {:ok, user}
    end
  end
end
