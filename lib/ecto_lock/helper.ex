defmodule EctoLock.Helper do
  alias EctoLock.BillPendingInvoices

  def create_invoices() do
    BillPendingInvoices.create_pending_invoice()
    BillPendingInvoices.create_pending_invoice()
    BillPendingInvoices.create_pending_invoice()
  end

  def bill_from_two_servers(locking?) do
    spawn(fn -> BillPendingInvoices.bill_pending_invoices(locking?) end)
    spawn(fn -> BillPendingInvoices.bill_pending_invoices(locking?) end)
  end
end
