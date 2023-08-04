# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EmailsApp.Repo.insert!(%EmailsApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
 EmailsApp.Accounts.register_user(%{
    email_address: "admin@otherompany.com",
    first_name: "otheradmin",
    last_name: "otheradmintesting",
    password: "123456789abc",
    password_confirmation: "123456789abc",
    role: "admin",
    msisdn: "Nairobi"
  })

  EmailsApp.Accounts.create_contacts(%{
    user_id: 1,
    contact_id: 3
  })