Model = Toruzou.module "Model"

Model.endpoint = (path) -> "/api/#{Toruzou.Configuration.api.version}/#{path}"
