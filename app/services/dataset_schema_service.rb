class DatasetSchemaService

  def initialize(dataset_schema = nil)
    @dataset_schema = dataset_schema
  end

  def create_dataset_schema(url_in_s3, user)  
    @dataset_schema = create_dataset_schema_for_user(user, url_in_s3)
    update_dataset_schema_with_json_schema
    @dataset_schema
  end

  def create_dataset_schema_for_user(user, url_in_s3)
    user.dataset_schemas.create(url_in_s3: url_in_s3)
  end

  def update_dataset_schema_with_json_schema
    schema_from_s3 = read_file_with_utf_8(@dataset_schema.url_in_s3)
    @dataset_schema.update(schema: schema_from_s3)
  end

  def read_file_with_utf_8(url)
    open(url).read.force_encoding("UTF-8")
  end

end