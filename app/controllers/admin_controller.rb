class AdminController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_licence
    layout 'admin'

    def set_licence
        $licenca = current_admin.admin_profile.licenca       
       
        if $empresa.nil?
            company = Company.find_by(admin_id: current_admin.id)
            $empresa = company.id
        else
            company = Company.find($empresa)
            if company.licenca !=  current_admin.admin_profile.licenca
                emp = Company.find_by(admin_id: current_admin.id)
                $empresa = emp.id
            end
        end
    end
end
