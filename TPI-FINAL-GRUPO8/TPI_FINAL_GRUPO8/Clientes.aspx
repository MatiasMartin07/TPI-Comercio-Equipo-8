<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Clientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Lista de Clientes</h2>

    <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="false" 
                CssClass="table table-striped" OnSelectedIndexChanged="gvClientes_SelectedIndexChanged"
        >
        <Columns>
            <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
            <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
            <asp:CheckBoxField HeaderText="Activo" DataField="Activo" />
            <asp:CommandField HeaderText="Accion" ShowSelectButton="true" SelectText="🖋️" />
        </Columns>


    </asp:GridView>


</asp:Content>
