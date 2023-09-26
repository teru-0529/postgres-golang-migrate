-- 2.受注(orders)

-- Create Table
CREATE TABLE received_order.orders (
  received_order_no varchar(10) NOT NULL check (LENGTH(received_order_no) >= 10),
  order_date date NOT NULL,
  person_in_charge varchar(30),
  customer_id varchar(3) NOT NULL check (LENGTH(customer_id) >= 3),
  comment text check (LENGTH(comment) >= 10),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL DEFAULT current_timestamp,
  created_by varchar(30),
  updated_by varchar(30)
);

-- Set Column Comment
COMMENT ON COLUMN received_order.orders.received_order_no IS '受注No';
COMMENT ON COLUMN received_order.orders.order_date IS '受注日';
COMMENT ON COLUMN received_order.orders.person_in_charge IS '担当者名';
COMMENT ON COLUMN received_order.orders.customer_id IS '得意先ID';
COMMENT ON COLUMN received_order.orders.comment IS 'コメント';
COMMENT ON COLUMN received_order.orders.created_at IS '作成日時';
COMMENT ON COLUMN received_order.orders.updated_at IS '更新日時';
COMMENT ON COLUMN received_order.orders.created_by IS '作成者';
COMMENT ON COLUMN received_order.orders.updated_by IS '更新者';

-- Set PK constraint
ALTER TABLE received_order.orders ADD PRIMARY KEY (
  received_order_no
);

-- Set FK constraint
ALTER TABLE received_order.orders ADD FOREIGN KEY (
  customer_id
)
REFERENCES received_order.customers (
  customer_id
);

-- Create 'set_update_at' Trigger
CREATE TRIGGER orders_updated
  BEFORE UPDATE
  ON received_order.orders
  FOR EACH ROW
EXECUTE PROCEDURE set_updated_at();


-- 3.受注明細(order_details)

-- Create Table
CREATE TABLE received_order.order_details (
  received_order_no varchar(10) NOT NULL check (LENGTH(received_order_no) >= 10),
  product_no varchar(10) NOT NULL check (LENGTH(product_no) >= 9),
  quantity integer check (quantity >= 0 AND quantity <= 99999),
  price integer check (price >= 0 AND price <= 99999),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  updated_at timestamp NOT NULL DEFAULT current_timestamp,
  created_by varchar(30),
  updated_by varchar(30)
);

-- Set Column Comment
COMMENT ON COLUMN received_order.order_details.received_order_no IS '受注No';
COMMENT ON COLUMN received_order.order_details.product_no IS '商品No';
COMMENT ON COLUMN received_order.order_details.quantity IS '数量';
COMMENT ON COLUMN received_order.order_details.price IS '定価';
COMMENT ON COLUMN received_order.order_details.created_at IS '作成日時';
COMMENT ON COLUMN received_order.order_details.updated_at IS '更新日時';
COMMENT ON COLUMN received_order.order_details.created_by IS '作成者';
COMMENT ON COLUMN received_order.order_details.updated_by IS '更新者';

-- Set PK constraint
ALTER TABLE received_order.order_details ADD PRIMARY KEY (
  received_order_no,
  product_no
);

-- Set FK constraint
ALTER TABLE received_order.order_details ADD FOREIGN KEY (
  received_order_no
)
REFERENCES received_order.orders (
  received_order_no
);

-- Create 'set_update_at' Trigger
CREATE TRIGGER order_details_updated
  BEFORE UPDATE
  ON received_order.order_details
  FOR EACH ROW
EXECUTE PROCEDURE set_updated_at();
