using Microsoft.SqlServer.Server;
using System.Data.SqlTypes;
using ViakViak_Sql;

public partial class StoredProcedures
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="content"></param>
    /// <remarks>See <see cref="https://www.codeproject.com/Tips/841439/Create-Run-Debug-and-Deploy-SQL-CLR-Function-with"/>Article "Create, Run, Debug and Deploy SQL CLR Function with Visual Studio 2013 Database Project"</remarks>
    [SqlProcedure]
    public static void ParseContent(int articleID, SqlString content)
    {
        var ac = new ArticleContent(articleID, content);
        ac.Parse();
    }
}
