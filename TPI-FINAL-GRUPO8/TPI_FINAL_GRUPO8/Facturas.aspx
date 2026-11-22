<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Facturas.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Facturas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container my-5">
        <div class="card shadow border mx-auto bg-white" style="max-width: 800px; min-height: 1000px;">
            <div class="d-flex align-items-center gap-2">
                <asp:Label ID="lblEstadoAnulada" runat="server" Text="ANULADA" CssClass="badge bg-danger fs-6" Visible="false" />
            </div>
            <div class="card-body p-4 p-md-5">

                <div class="d-flex flex-wrap justify-content-end gap-2 mb-4 d-print-none">
                    <a href="HistorialVenta.aspx"
                        class="btn btn-outline-secondary btn-sm">Historial Venta
    </a>

                    <a href="Ventas.aspx"
                        class="btn btn-outline-success btn-sm">Nueva Venta
    </a>

                    <asp:Button ID="btnDescargarPdf" runat="server"
                        Text="Descargar PDF"
                        CssClass="btn btn-primary btn-sm"
                        CausesValidation="false"
                        OnClick="btnDescargarPdf_Click" />
                </div>

                <asp:Label ID="lblErrorPdf" runat="server"
                    CssClass="text-danger d-block mb-3"
                    role="alert" />

                <div class="row mb-4">
                    <div class="col-sm-6">
                        <h3 class="text-dark fw-bold mb-3">Comprobante de Venta</h3>
                        <p class="mb-1 text-muted">Datos del Cliente </p>
                        <p class="mb-1"><span class="text-secondary">Nombre y Apellido:</span>
                            <asp:Label ID="lblNombreCliente" runat="server"></asp:Label></p>
                        <p class="mb-0"><span class="text-secondary">DNI:</span>
                            <asp:Label ID="lblDni" runat="server"></asp:Label></p>
                    </div>
                    <div class="col-sm-6 text-sm-end mt-3 mt-sm-0">
                        <h4 class="text-secondary fw-semibold">Factura</h4>
                        <p class="mb-1"><span class="text-secondary">Nº:</span>
                            <asp:Label ID="lblNroFactura" runat="server"></asp:Label></p>
                        <p class="mb-0"><span class="text-secondary">Fecha:</span>
                            <asp:Label ID="lblFecha" runat="server"></asp:Label></p>
                    </div>
                </div>

                <hr class="my-4" />

                <div class="table-responsive mb-4">
                    <asp:GridView ID="gvDetalleVenta" runat="server" CssClass="table table-bordered align-middle mb-0" AutoGenerateColumns="false">
                        <Columns>
                            <asp:BoundField DataField="Producto.Nombre" HeaderText="Producto" />
                            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                            <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio Unit." DataFormatString="{0:C}" />
                            <asp:BoundField DataField="SubTotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
                        </Columns>
                    </asp:GridView>
                </div>

                <div class="row align-items-center border-top pt-3 mt-5">
                    <div class="col-sm-6">
                        <p class="text-muted mb-0">Gracias por su compra </p>
                    </div>
                    <div class="col-sm-6 text-sm-end">
                        <div class="d-flex justify-content-sm-end align-items-center gap-2">
                            <h4 class="mb-0 text-dark fw-bold">Total:</h4>
                            <h4 class="mb-0 text-dark fw-bold">
                                <asp:Label ID="lblTotal" runat="server"></asp:Label></h4>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>




</asp:Content>
