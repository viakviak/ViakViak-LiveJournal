using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Diagnostics;

public partial class StoredProcedures
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="content"></param>
    /// <remarks>See <see cref="https://www.codeproject.com/Tips/841439/Create-Run-Debug-and-Deploy-SQL-CLR-Function-with"/>Article "Create, Run, Debug and Deploy SQL CLR Function with Visual Studio 2013 Database Project"</remarks>
    [SqlProcedure]
    public static void ParseContent(SqlString content)
    {
        string contentText = content.Value;
        if (String.IsNullOrEmpty(contentText)) return;

        contentText = "<content>" + contentText + "</content>";
        Debug.WriteLine(contentText);
    }
}
