defmodule CatcastsWeb.AuthControllerWeb do
  use CatcastsWeb.ConnCase

  alias Catcasts.Repo
  alias Catcasts.User

  @ueberauth %{credentials: %{token: "fdsnoafhnoofh08h38h"},
    info: %{email: "batman@example.com", first_name: "Bruce", last_name: "Wayne"},
		provider: :google
  }

  test "redirect user to Google for authentication", %{conn: conn} do
    conn = get conn, "/auth/google?scope=email%20profile"
    assert redirected_to(conn, 302)
  end

	test "create user from Google  information", %{conn: conn} do
		conn = conn
		|> assign(:ueberauth_auth, @ueberauth)
		|> get("/auth/google/callback")

    users = User |> Repo.all
    assert Enum.count(users) == 1
    assert get_flash(conn, :info) == "Thank you for signing in!"


	end
end
