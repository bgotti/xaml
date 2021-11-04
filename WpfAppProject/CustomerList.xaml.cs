using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Data.SqlClient;
using System.Data;
using System.Collections;

namespace WpfAppProject
{
    /// <summary>
    /// Interaction logic for ListeClients.xaml
    /// </summary>
    public partial class CustomerList : Window
    {

        static string conString = @"Data Source = (LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\USERS\BRIAN\DESKTOP\WpfAppProject\DatabaseProject.mdf;Integrated Security = True; Connect Timeout = 30";

        SqlConnection connection = new SqlConnection(conString);

        public string customerid { get; set; }

        public CustomerList(string customerid)
        {
            InitializeComponent();

            BindDataCustomers(customerid);

        }




        //BindDataClients method to display client by selecting ClientID
        void BindDataCustomers(string customerid)
        {

            SqlCommand command = new SqlCommand("SELECT * FROM Customers WHERE CustomerID = " + customerid, connection);
            SqlDataAdapter sd = new SqlDataAdapter(command);
            DataTable table = new DataTable();
            sd.Fill(table);


            dataGridCustomer.ItemsSource = table.DefaultView;

        }


    }

}
