<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HistorialVenta.aspx.cs" Inherits="TPI_FINAL_GRUPO8.HistorialVenta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="con-costados banner-modulo d-flex align-items-center
    justify-content-between gap-3 bg-primary bg-opacity-10
    border border-primary border-opacity-25 rounded
    p-4 p-xl-5 mb-4">

        <div>
            <h1 class="h2 fw-semibold mb-2">Historial de ventas</h1>
            <p class="text-secondary mb-0">
                Consultá tus ventas y accedé a sus comprobantes.
       
            </p>
        </div>

        <span class="display-3 flex-shrink-0" aria-hidden="true">🧾</span>
    </div>

    <div class="border border-bottom-0 rounded-top bg-light p-3">
        <div class="row g-3 align-items-end">

            <div class="col-12 col-md-8">
                <asp:Label runat="server"
                    Text="Buscar venta"
                    AssociatedControlID="txtFiltro"
                    CssClass="form-label" />

                <asp:TextBox ID="txtFiltro" runat="server"
                    CssClass="form-control"
                    Style="max-width: none;"
                    placeholder="Nro. de factura, cliente o fecha"
                    AutoPostBack="true"
                    OnTextChanged="txtFiltro_TextChanged" />
            </div>

            <div class="col-12 col-md-4">
                <asp:Label runat="server"
                    Text="Estado"
                    AssociatedControlID="ddlEstadoVenta"
                    CssClass="form-label" />

                <asp:DropDownList ID="ddlEstadoVenta" runat="server"
                    CssClass="form-select"
                    Style="max-width: none;"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlEstadoVenta_SelectedIndexChanged">

                    <asp:ListItem Text="Todos" Value="Todos" />
                    <asp:ListItem Text="Activos" Value="Activos" />
                    <asp:ListItem Text="Anulados" Value="Anulados" />
                </asp:DropDownList>
            </div>

        </div>
    </div>
    <div class="table-responsive border border-top-0 rounded-bottom">
        <asp:GridView ID="gvVentas" runat="server" CssClass="table table-striped table-bordered align-middle mb-0" AutoGenerateColumns="false"
    DataKeyNames="Id" OnRowCommand="gvVentas_RowCommand" OnRowDataBound="gvVentas_RowDataBound" ShowHeaderWhenEmpty="true" EmptyDataText="No hay ventas para mostrar...">
            <Columns>
                <asp:BoundField HeaderText="Fecha" DataField="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                <asp:BoundField HeaderText="Factura" DataField="NroFactura" />
                <asp:BoundField HeaderText="Cliente" DataField="Cliente.Nombre" />
                <asp:BoundField HeaderText="Total" DataField="Total" DataFormatString="{0:C2}" />
                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <asp:Button runat="server" Text="Ver Factura" CssClass="btn btn-outline-success btn-sm"
                            CommandName="VerFactura"
                            CommandArgument='<%# Eval("Id") %>' />
                        <asp:Button ID="btnAnular" runat="server" Text="Anular" CssClass="btn btn-outline-danger btn-sm" CommandName="AnularVenta" CommandArgument='<%# Eval("Id") %>'
                            Visible='<%# !Convert.ToBoolean(Eval("Anulado")) %>' OnClientClick="return confirm('¿Seguro que querés anular esta venta? Se devolvera el Stock');" />
                        <asp:Label runat="server" Text="Anulado" CssClass="badge bg-danger" Visible='<%# Convert.ToBoolean(Eval("Anulado")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <asp:Label ID="lblError" runat="server"></asp:Label>



</asp:Content>
