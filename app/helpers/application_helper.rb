module ApplicationHelper

  def institution_name
    $DeployingInstitutionName || "Your Institution Name"
  end
end
