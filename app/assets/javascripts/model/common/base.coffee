Model = Toruzou.module "Model"

Model.endpoint = (path) -> "#{Toruzou.Configuration.root}/api/#{Toruzou.Configuration.api.version}/#{path}"
