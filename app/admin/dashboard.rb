ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Usuarios" do
          ul do
            table_for User.all.order("name asc").each do |user|
               column("nombre") { |user| user.name  }
               column("cuentas que sigue") { |user| user.followings.count}
               column("tweets") { |user| user.tweets.count}
               column("likes") { |user| user.likes.count}
               column("retweets") { |user| user.retweets.count}
               column("Editar") {|user| link_to('Edit',  edit_admin_user_path(user.id))}
               column("Eliminar") {|user| link_to 'Destroy', admin_user_path(user.id), method: :delete, data: { confirm: 'Estás Seguro?' }, class: "btn btn-info"}
              end
            end
          end
        end
      # column do
      #   panel "Info" do
      #     para "Welcome to ActiveAdmin."
      #   end
      # end
    end
  end # content
end
