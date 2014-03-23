::ActiveRecord::Base.send :include, Embeddable::Concerns::Embeddable if defined?(ActiveRecord)
