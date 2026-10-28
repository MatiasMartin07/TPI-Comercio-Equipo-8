using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPI_FINAL_GRUPO8
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtUsuario_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtUsuario.Text))
            {
                lblError.Text = string.Empty;
                txtUsuario.BorderColor = System.Drawing.Color.Gray;
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            try
            {
                //validacion
                if (string.IsNullOrEmpty(txtUsuario.Text))
                {
                    lblError.Text = "Debe ingresar un usuario";
                    txtUsuario.BorderColor = System.Drawing.Color.Red;
                    return;
                }
                else
                {
                    //buscar en la base que ese usuario exista

                }

            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
            }
        }
    }
}