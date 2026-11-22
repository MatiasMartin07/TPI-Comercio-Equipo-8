<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HistorialVenta.aspx.cs" Inherits="TPI_FINAL_GRUPO8.HistorialVenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="text-center" style="color: #6ea8fe;">Historial de Ventas</h2>

    <div class="mb-3">
    <asp:Label runat="server" Text="Buscar" AssociatedControlID="txtFiltro" CssClass="form-label"></asp:Label>
    <div class="d-flex align-items-end gap-2">
        <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control flex-grow-1" placeholder="Buscar por Nro Factura, Cliente,..." AutoPostBack="true" OnTextChanged="txtFiltro_TextChanged"></asp:TextBox>

        <asp:DropDownList ID="ddlEstadoVenta" runat="server" CssClass="form-select" Style="max-width: 150px;" AutoPostBack="true" OnSelectedIndexChanged="ddlEstadoVenta_SelectedIndexChanged" >
            <asp:ListItem Text="Todos" Value="Todos" />
            <asp:ListItem Text="Activos" Value="Activos" />
            <asp:ListItem Text="Anulados" Value="Anulados" />
        </asp:DropDownList>
    </div>
</div>

    <asp:GridView ID="gvVentas" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="false"
        DataKeyNames="Id" OnRowCommand="gvVentas_RowCommand" ShowHeaderWhenEmpty="true" EmptyDataText="No hay ventas para mostrar..." >
        <Columns>
            <asp:BoundField HeaderText="Fecha" DataField="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
            <asp:BoundField HeaderText="Factura" DataField="NroFactura" />
            <asp:BoundField HeaderText="Cliente" DataField="Cliente.Nombre" />
            <asp:BoundField HeaderText="Total" DataField="Total" DataFormatString="{0:C2}" />
            <asp:TemplateField HeaderText="Factura">
                <ItemTemplate>
                    <asp:Button runat="server" Text="Ver Factura" CssClass="btn btn-outline-success btn-sm"
                      CommandName="VerFactura"
                      CommandArgument='<%# Eval("Id") %>'
                        />
                    <asp:Button runat="server" Text="Anular" CssClass="btn btn-outline-danger btn-sm" CommandName="AnularVenta" CommandArgument='<%# Eval("Id") %>'
                        Visible='<%# !Convert.ToBoolean(Eval("Anulado")) %>' OnClientClick="return confirm('¿Seguro que querés anular esta venta? Se devolvera el Stock');" />
                    <asp:Label  runat="server" Text="Anulado" CssClass="badge bg-danger" Visible='<%# Convert.ToBoolean(Eval("Anulado")) %>'></asp:Label>
                    </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Label ID="lblError" runat="server"></asp:Label>



</asp:Content>
