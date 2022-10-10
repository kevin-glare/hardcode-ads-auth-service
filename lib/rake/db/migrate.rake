namespace :db do
  desc 'Run database migrations'
  task :migrate, %i[version] => :configurable do |_t, args|
    require 'sequel/core'
    require 'sequel/extensions/schema_dumper'

    Sequel.extension :migration

    Sequel.connect(AppSetting.db.to_h) do |db|
      migrations = File.expand_path('../../../db/migrations', __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)

      db.extension :schema_dumper

      version = "# version: #{db[:schema_migrations].all.first[:filename].to_i})"
      schema = db.dump_schema_migration

      File.write(File.expand_path('../../../../db/schema.rb', __FILE__), "#{version}\n\n#{schema}", mode: 'w')
    end
  end
end
