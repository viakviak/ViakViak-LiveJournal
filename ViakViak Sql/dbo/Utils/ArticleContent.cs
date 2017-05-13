using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlTypes;
using System.Xml;
using System.Data.SqlClient;
using System.Diagnostics;

namespace ViakViak_Sql
{
    /// <summary>
    /// LiveJournal Article Content parsing and processing
    /// </summary>
    public class ArticleContent
    {
        #region private variables
        private int _articleID = 0;
        private XmlDocument _xmlDoc = new XmlDocument();
        #endregion

        #region construction
        /// <summary>
        /// default constructor
        /// </summary>
        public ArticleContent()
        {

        }

        /// <summary>
        /// constructor initializing object with article data
        /// </summary>
        /// <param name="articleID"></param>
        /// <param name="articleContent"></param>
        public ArticleContent(int articleID, SqlString articleContent)
        {
            SetContent(articleID, articleContent);
        }
        #endregion

        #region public members
        /// <summary>
        /// Parses article content
        /// </summary>
        /// <returns></returns>
        public bool Parse()
        {
            if (_articleID <= 0 || _xmlDoc == null) return false;

            try
            {
                using (var conn = new SqlConnection("context connection=true"))
                {
                    conn.Open();

                    ProcessWord(conn);
                    ProcessTranslation(conn);
                    ProcessSummary(conn);
                    ProcessRoots(conn);
                }
            }
            catch (Exception ex)
            {
                Debug.Write("Error: " + ex.Message + "\n" + ex.StackTrace);
            }
            return true;
        }
        #endregion

        #region private members
        private void SetContent(int articleID, SqlString articleContent)
        {
            SetContent(articleID, articleContent.Value);
        }

        private void SetContent(int articleID, string contentText)
        {
            _articleID = articleID;

            if (!String.IsNullOrEmpty(contentText))
            {
                contentText = "<content>" + contentText + "</content>";
                _xmlDoc.LoadXml(contentText);
            }
        }

        private bool ProcessWord(SqlConnection conn)
        {
            return false;
        }

        private bool ProcessTranslation(SqlConnection conn)
        {
            return false;
        }

        private bool ProcessSummary(SqlConnection conn)
        {
            return false;
        }

        private bool ProcessRoots(SqlConnection conn)
        {
            return false;
        }
        #endregion
    }
}
