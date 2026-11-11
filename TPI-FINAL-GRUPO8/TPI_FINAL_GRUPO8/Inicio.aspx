<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bg-light border rounded p-3 p-md-4 p-xl-5 mb-4">
        <h1 class="h3 mb-2">Bienvenida al Sistema de Gestión Comercial</h1>
        <p class="mb-0">Elegí un módulo para empezar.</p>
    </div>

    <h2 class="h5 mb-3">Módulos principales</h2>

    <div class="row g-3">
        <div class="col-12 col-sm-6 col-lg-4">
            <a href="Productos.aspx" class="btn btn-outline-primary w-100">Productos</a>
        </div>
        <div class="col-12 col-sm-6 col-lg-4">
            <a href="Marcas.aspx" class="btn btn-outline-primary w-100">Marcas</a>
        </div>
        <div class="col-12 col-sm-6 col-lg-4">
            <a href="Categorias.aspx" class="btn btn-outline-primary w-100">Categorías</a>
        </div>
        <div class="col-12 col-sm-6 col-lg-4">
            <a href="Clientes.aspx" class="btn btn-outline-primary w-100">Clientes</a>
        </div>
        <div class="col-12 col-sm-6 col-lg-4">
            <a href="Proveedores.aspx" class="btn btn-outline-primary w-100">Proveedores</a>
        </div>
        <div class="col-12 col-sm-6 col-lg-4">
            <a href="Compras.aspx" class="btn btn-outline-primary w-100">Compras</a>
        </div>
        <div class="col-12 col-sm-6 col-lg-4">
            <a href="Ventas.aspx" class="btn btn-outline-primary w-100">Ventas</a>
        </div>
        <div class="col-12 col-sm-6 col-lg-4">
            <a href="Facturas.aspx" class="btn btn-outline-primary w-100">Facturas</a>
        </div>
    </div>
</asp:Content>
