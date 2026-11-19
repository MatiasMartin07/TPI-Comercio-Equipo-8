<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ventas.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Ventas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container my-4">
    
    <div class="row mb-4 align-items-center">
        <div class="col-md-6 d-flex align-items-center gap-3">
            <h2 class="mb-0 fw-bold text-primary">🛒 Nueva Venta</h2>
            <a href="HistorialVenta.aspx" class="btn btn-outline-secondary btn-sm">Ver Historial</a>
        </div>
        <div class="col-md-6 d-flex justify-content-md-end mt-3 mt-md-0">
            <div class="card p-3 shadow-sm bg-light border-0" style="width: 260px;">
                <div class="card-body p-0">
                    <asp:Label ID="lblFactura" runat="server" Text="Nro Factura" CssClass="form-label fw-bold text-secondary small mb-1"></asp:Label>
                    <asp:TextBox ID="txtNroFactura" runat="server" CssClass="form-control text-end fw-bold bg-white"></asp:TextBox>
                </div>
            </div>
        </div>
    </div>

<asp:UpdatePanel ID="upCliente" runat="server">
        <ContentTemplate>
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 text-secondary fw-semibold">Datos del Cliente</h5>
                </div>
                <div class="card-body p-4">
                    <div class="row g-3">
                        <div class="col-12 col-md-6">
                            <asp:Label ID="lblDni" runat="server" Text="DNI o CUIT" CssClass="form-label text-muted small"></asp:Label>
                            <asp:TextBox ID="txtDni" runat="server" placeholder="DNI / CUIT" CssClass="form-control" OnTextChanged="txtDni_TextChanged" AutoPostBack="true"></asp:TextBox>
                            <asp:Label ID="lblErrorDni" runat="server" CssClass="text-danger small mt-1 d-block"></asp:Label>
                        </div>

                        <div class="col-12 col-md-6">
                            <asp:Label ID="lblNombre" runat="server" Text="Nombre" CssClass="form-label text-muted small"></asp:Label>
                            <asp:TextBox ID="txtNombre" runat="server" placeholder="Nombre" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-12 text-end mt-3">
                            <asp:Button ID="btnValidar" runat="server" Text="Validar" CssClass="btn btn-outline-success px-4" OnClick="btnValidar_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

<asp:UpdatePanel ID="upProducto" runat="server">
        <ContentTemplate>
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 text-secondary fw-semibold">Producto</h5>
                </div>
                <div class="card-body p-4">
                    <div class="row g-3">
                        <div class="col-12 col-md-4">
                            <asp:Label ID="lblIdProducto" runat="server" Text="Producto" CssClass="form-label text-muted small"></asp:Label>
                            <asp:TextBox ID="txtIdProducto" runat="server" placeholder="Id del Producto" CssClass="form-control" OnTextChanged="txtIdProducto_TextChanged" AutoPostBack="true"></asp:TextBox>
                            <asp:Label ID="lblErrorId" runat="server" CssClass="text-danger fw-bold small mt-1 d-block"></asp:Label>
                        </div>

                        <div class="col-12 col-md-8">
                            <asp:Label ID="lblNombreProducto" runat="server" Text="Nombre" CssClass="form-label text-muted small"></asp:Label>
                            <asp:TextBox ID="txtNombreProducto" runat="server" placeholder="Nombre del Producto" CssClass="form-control"></asp:TextBox>
                            <asp:Label ID="lblErrorProducto" runat="server" CssClass="text-danger fw-bold small mt-1 d-block"></asp:Label>
                        </div>
                        
                        <div class="col-12 text-end">
                            <asp:Button ID="btnBuscarProducto" runat="server" Text="Buscar Producto" CssClass="btn btn-outline-success px-4" OnClick="btnBuscarProducto_Click" />
                        </div>

                        <div class="col-12 col-md-4">
                            <asp:Label ID="lblCantidad" runat="server" Text="Cantidad" CssClass="form-label text-muted small"></asp:Label>
                            <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" placeholder="0" TextMode="Number" min="0" step="1" OnTextChanged="txtCantidad_TextChanged" AutoPostBack="true"></asp:TextBox>
                        </div>

                        <div class="col-12 col-md-4">
                            <asp:Label ID="lblPrecio" runat="server" Text="Precio $" CssClass="form-label text-muted small"></asp:Label>
                            <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" placeholder="$"></asp:TextBox>
                        </div>

                        <div class="col-12 col-md-4">
                            <asp:Label ID="lblSubTotal" runat="server" Text="SubTotal" CssClass="form-label text-muted small"></asp:Label>
                            <asp:TextBox ID="txtSubtotal" runat="server" CssClass="form-control" placeholder="$"></asp:TextBox>
                        </div>

                        <div class="col-12 text-end mt-3">
                            <asp:Button ID="btnAgregarProducto" runat="server" Text="Agregar Producto" CssClass="btn btn-outline-success px-4" OnClick="btnAgregarProducto_Click" />
                        </div>
                    </div>

                    <hr class="my-4 text-muted opacity-25" />
                    
                    <div class="table-responsive">
                        <asp:GridView ID="gvCarritoProducto" runat="server" CssClass="table table-hover align-middle mb-0" AutoGenerateColumns="false"
                             OnRowCommand="gvCarritoProducto_RowCommand">
                            <Columns>
                                <asp:BoundField HeaderText="Nombre" DataField="NombreProducto" />
                                <asp:BoundField HeaderText="Cantidad" DataField="Cantidad" />
                                <asp:BoundField HeaderText="Precio unidad" DataField="PrecioUnitario" DataFormatString="{0:C}" />
                                <asp:BoundField HeaderText="Subtotal" DataField="SubTotal" DataFormatString="{0:C}" />
                                <asp:ButtonField HeaderText="Acción" ButtonType="Button" CommandName="Quitar" Text="Quitar" ControlStyle-CssClass="btn btn-outline-danger btn-sm" />
                            </Columns>
                        </asp:GridView> 
                    </div>
                </div>
            </div>

            <div class="row justify-content-end mb-4">
                <div class="col-12 col-md-4">
                    <div class="input-group shadow-sm">
                        <span class="input-group-text fw-bold bg-light text-secondary">Total $</span>
                        <asp:TextBox ID="txtTotal" runat="server" placeholder="0.00" CssClass="form-control text-end fw-bold fs-5 bg-white"></asp:TextBox>
                    </div>
                </div>
            </div>   
        </ContentTemplate>
    </asp:UpdatePanel>

    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-5 gap-3">
        <asp:Label ID="lblError" runat="server" CssClass="text-danger fw-bold"></asp:Label>
        <asp:Button ID="btnFinalizar" runat="server" Text="Finalizar Venta" CssClass="btn btn-primary btn-lg px-5 shadow-sm" OnClick="btnFinalizar_Click" OnClientClick="this.disabled = true; this.value = 'Procesando...';"
            UseSubmitBehavior="false" />
    </div>

</div>

  

</asp:Content>
