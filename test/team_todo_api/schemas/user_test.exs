defmodule TeamTodoApi.Schemas.UserTest do
  use TeamTodoApi.DataCase

  alias TeamTodoApi.Schemas.User

  describe "changeset/2" do
    test "When all params are valid, returns a valid changeset." do
      params = %{
        name: "azevedoguigo",
        email: "test@example.com",
        password: "supersenha"
      }

      response = User.changeset(%User{}, params)

      assert %Ecto.Changeset{valid?: true} = response
    end
  end

  test "When one of the required fields is missing, it returns an error message." do
    params = %{
      name: "", # Ex: name cannot be blank.
      email: "test@example.com",
      password: "supersenha"
    }

    response = User.changeset(%User{}, params)

    assert errors_on(response) == %{name: ["can't be blank"]}
  end

  test "When the given name has less than two characters, it returns an error message." do
    params = %{
      name: "a",
      email: "test@example.com",
      password: "supersenha"
    }

    response = User.changeset(%User{}, params)

    assert errors_on(response) == %{name: ["should be at least 2 character(s)"]}
  end

  test "When the name has more than 40 characters, it returns an error message." do
    params = %{
      # This name has more than 40 characters.
      name: "José João Pedro Barrichello Senna Da Silva",
      email: "test@example.com",
      password: "supersenha"
    }

    response = User.changeset(%User{}, params)

    assert errors_on(response) == %{name: ["should be at most 40 character(s)"]}
  end

  test "When the given email has less than ten characters, it returns an error message." do
    params = %{
      name: "azevedoguigo",
      email: "@gmail.com",
      password: "supersenha"
    }

    response = User.changeset(%User{}, params)

    assert errors_on(response) == %{email: ["should be at least 11 character(s)"]}
  end

  test "When the email contains more than 40 characters, it returns an error." do
    params = %{
      name: "azevedoguigo",
      email: "too-loooooooong-email-address@example.com",
      password: "supersenha"
    }

    response = User.changeset(%User{}, params)

    assert errors_on(response) == %{email: ["should be at most 40 character(s)"]}
  end

  test "When the email format is invalid, it returns an error message." do
    params = %{
      name: "azevedoguigo",
      email: "testexample.com", # This email address is missing the "@".
      password: "supersenha"
    }

    response = User.changeset(%User{}, params)

    assert errors_on(response) == %{email: ["has invalid format"]}
  end

  test "When the password is not provided, it returns an error message." do
    params = %{
      name: "azevedoguigo",
      email: "test@example.com",
      password: "" # Blank password field.
    }

    response = User.changeset(%User{}, params)

    assert errors_on(response) == %{password: ["can't be blank"]}
  end

  test "When the provided password is less than six characters long, it returns an error message." do
    params = %{
      name: "azevedoguigo",
      email: "test@example.com",
      password: "12345"
    }

    response = User.changeset(%User{}, params)

    assert errors_on(response) == %{password: ["should be at least 6 character(s)"]}
  end

  test "When the provided password contains more than 30 characters, it returns an error." do
    params = %{
      name: "azevedoguigo",
      email: "test@example.com",
      password: "45a23a4f-4a9d-4035-9071-8dba94205d50"
    }

    response = User.changeset(%User{}, params)

    assert errors_on(response) == %{password: ["should be at most 30 character(s)"]}
  end
end
