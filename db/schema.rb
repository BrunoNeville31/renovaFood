# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_22_034724) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "licenca"
    t.string "nome"
    t.string "sobrenome"
    t.bigint "admin_id"
    t.string "fone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admin_profiles_on_admin_id"
  end

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nome"
    t.string "img"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_categories_on_company_id"
  end

  create_table "clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nome"
    t.string "fone"
    t.string "cpf"
    t.string "email"
    t.string "rua"
    t.string "numero"
    t.string "cidade"
    t.string "estado"
    t.string "cep"
    t.string "complemento"
    t.boolean "status", default: true
    t.date "aniversario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.string "src"
    t.index ["company_id"], name: "index_clients_on_company_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nome"
    t.string "rua"
    t.string "numero"
    t.string "estado"
    t.string "cidade"
    t.string "cep"
    t.string "bairro"
    t.string "licenca"
    t.bigint "admin_id"
    t.string "cnpj"
    t.string "fone"
    t.integer "status"
    t.string "data_cobranca"
    t.string "taxa"
    t.string "valor"
    t.string "valor_centavos"
    t.string "tuesday_open"
    t.string "tuesday_close"
    t.string "wednesday_open"
    t.string "wednesday_close"
    t.string "thursday_open"
    t.string "thursday_close"
    t.string "friday_open"
    t.string "friday_close"
    t.string "saturday_open"
    t.string "saturday_close"
    t.string "sunday_open"
    t.string "sunday_close"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "venda_bot", default: false
    t.string "monday_open"
    t.string "monday_close"
    t.string "taxa_entrega"
    t.index ["admin_id"], name: "index_companies_on_admin_id"
  end

  create_table "compose_product_menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "product_simple_id"
    t.integer "qtd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_compose_product_menus_on_product_id"
    t.index ["product_simple_id"], name: "index_compose_product_menus_on_product_simple_id"
  end

  create_table "licencas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "numero"
    t.integer "qtd_empresa"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.boolean "status"
    t.string "nome"
    t.boolean "parcela"
    t.integer "num_parcela"
    t.integer "tipo"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_payments_on_company_id"
  end

  create_table "product_simples", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nome"
    t.float "valor", default: 0.0
    t.integer "estoque_min"
    t.integer "estoque_atual"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.boolean "status", default: true
    t.index ["company_id"], name: "index_product_simples_on_company_id"
  end

  create_table "product_steps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "descricao"
    t.bigint "product_id"
    t.integer "limite"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_product_steps_on_company_id"
    t.index ["product_id"], name: "index_product_steps_on_product_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nome"
    t.string "descricao"
    t.float "valor", default: 0.0
    t.float "valor_promocional", default: 0.0
    t.boolean "promocao_ativa", default: false
    t.integer "tempo_preparo"
    t.integer "estoque_atual"
    t.integer "estoque_min"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: true
    t.boolean "monday", default: true
    t.boolean "tuesday", default: true
    t.boolean "wednesday", default: true
    t.boolean "thursday", default: true
    t.boolean "friday", default: true
    t.boolean "saturday", default: true
    t.boolean "sunday", default: true
    t.bigint "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "sale_product_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "sale_product_id"
    t.bigint "side_product_step_id"
    t.string "valor_adicional"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_product_id"], name: "index_sale_product_details_on_sale_product_id"
    t.index ["side_product_step_id"], name: "index_sale_product_details_on_side_product_step_id"
  end

  create_table "sale_products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "sale_id"
    t.bigint "product_id"
    t.string "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_sale_products_on_product_id"
    t.index ["sale_id"], name: "index_sale_products_on_sale_id"
  end

  create_table "sales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "company_id"
    t.string "numero_pedido"
    t.integer "status"
    t.integer "status_entrega"
    t.integer "status_pagamento"
    t.string "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_sales_on_company_id"
  end

  create_table "side_product_steps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nome"
    t.string "valor"
    t.bigint "product_step_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_simples_id"
    t.index ["product_simples_id"], name: "index_side_product_steps_on_product_simples_id"
    t.index ["product_step_id"], name: "index_side_product_steps_on_product_step_id"
  end

  create_table "sides", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nome"
    t.string "valor"
    t.string "limite"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_sides_on_company_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_profiles", "admins"
  add_foreign_key "categories", "companies"
  add_foreign_key "clients", "companies"
  add_foreign_key "companies", "admins"
  add_foreign_key "compose_product_menus", "product_simples"
  add_foreign_key "compose_product_menus", "products"
  add_foreign_key "payments", "companies"
  add_foreign_key "product_simples", "companies"
  add_foreign_key "product_steps", "companies"
  add_foreign_key "product_steps", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "companies"
  add_foreign_key "sale_product_details", "sale_products"
  add_foreign_key "sale_product_details", "side_product_steps"
  add_foreign_key "sale_products", "products"
  add_foreign_key "sale_products", "sales"
  add_foreign_key "sales", "companies"
  add_foreign_key "side_product_steps", "product_simples", column: "product_simples_id"
  add_foreign_key "side_product_steps", "product_steps"
  add_foreign_key "sides", "companies"
end
