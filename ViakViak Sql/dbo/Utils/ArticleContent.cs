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
        #region declarations
        const char LINE_DLM = '\n';
        const char WORD_DLM = ' ';
        static readonly string[] ROOT_DLM = { " - " };

        #endregion

        #region private variables
        private int _articleID = 0;
        private XmlDocument _xmlDoc = new XmlDocument();
        private SqlConnection _conn = null;
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
                    _conn = conn;

                    ProcessWord();
                    ProcessTranslation();
                    ProcessComponent();
                    ProcessSummary();
                    _conn = null;
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

        private bool ProcessWord()
        {
            return ProcessHeader("word");
        }

        private bool ProcessTranslation()
        {
            return ProcessHeader("translation");
        }

        private bool ProcessSummary()
        {
            return ProcessHeader("summary");
        }

        private bool ProcessComponent()
        {
            return ProcessHeader("component");
        }

        private bool ProcessHeader(string headerName)
        {
            XmlNode wordNode = _xmlDoc.SelectSingleNode("/content/span[@viak='" + headerName + "']");
            if (wordNode == null) return false;

            var tokens = wordNode.InnerText.Split('\n');
            string headerContent = tokens[0];
            return ProcessRoots(tokens[1]);
        }

        /// <summary>
        /// Processes root content
        /// </summary>
        /// <param name="conn"></param>
        /// <param name="rootContent">root content</param>
        /// <returns>flag "processed"</returns>
        /// <remarks>Example of root content:
        /// МФ - муфта muff(англ:муфта) амфора миф Мефодий амфибия амфитеатр мафия муфтий
        /// ФМ - family(англ:семья) fume(англ:дым) feminine(англ:женский) female(англ:матка) Фома
        /// Мт - мать матка мата(араб:смерть) мат метан муть омут митра метр метка мэтр матрона материя митральеза мотать meat(англ:мясо, мякоть, суть) мыть мять метить маятник
        /// тМ - том тема team(англ:команда, артель) тьма туман темень тумен атаман тумак комета томный тамга
        /// - Мд - mud(англ:грязь, слякоть) мёд медь мудрый мода мадьяр 
        /// - дМ - дума дом дым Дима
        /// - Мв - move(англ:движение) омовение умывание
        /// - вМ - вымя вам 
        /// - - Мб - mob(англ:толпа, банда, мафия) mobile(англ:подвижный) мебель амбар амёба амбал амёба
        /// - - Бм - объем бомба бумеранг бум бумага beam(англ:луч, балка, щирина) бомж bum(англ:бомж)
        /// - - - Пм - помощь пума
        /// - - - мП - ампула empale(англ:пронзать, обносить частоколом) империя emporium(англ:рынок) mop(англ:швабра, космы)
        private bool ProcessRoots(string rootContent)
        {
            if (string.IsNullOrEmpty(rootContent)) return false;
            rootContent = rootContent.Trim();
            if (string.IsNullOrEmpty(rootContent)) return false;

            foreach(var line in rootContent.Split(LINE_DLM))
            {
                var rootTokens = line.Split(ROOT_DLM, StringSplitOptions.RemoveEmptyEntries);
                if (rootTokens.Length < 2) continue;

                int rootLevel = rootTokens.Length - 2;
                string rootName = rootTokens[rootLevel].Trim();
                int rootID = SaveRoot(rootName);
                if (rootID <= 0) continue;

                string wordsContent = rootTokens[rootTokens.Length - 1].Trim();
                var rootWords = wordsContent.Split(WORD_DLM);

                foreach(string word in rootWords)
                {
                    SaveRootWord(rootID, word);
                }
            }
            return false;
        }

        /// <summary>
        /// Get root id or inserts a new one
        /// </summary>
        /// <param name="componentName">one or several "/"-delimited component names</param>
        /// <param name="isRoot">optional flag "is root"</param>
        /// <param name="isPrefix">optional flag "is prefix"</param>
        /// <returns>int value of Root ID</returns>
        /// <remarks>Component could be a also a root or prefix</remarks>
        private int SaveComponent(string componentName, bool isRoot = false, bool isPrefix = false)
        {
            return 0;
        }

        /// <summary>
        /// Checks for Component-Word association. If word doesn't exits, inserts a new one.
        /// If word existed, but doesn't have a root reference, it will be updated.
        /// If different root is already referenced, comment will be updated.
        /// </summary>
        /// <param name="componentID">Root ID value</param>
        /// <param name="wordName">Word, which could include following it translation(s) to other languages in parenthesis</param>
        /// <returns>int value of ComponentWordID</returns>
        private int SaveComponentWord(int componentID, string wordName)
        {
            return 0;
        }

        /// <summary>
        /// Saves language 
        /// </summary>
        /// <param name="languageName"></param>
        /// <returns></returns>
        private int SaveLanguage(string languageName)
        {
            return 0;
        }
        #endregion

        #region static public methods
        /// <summary>
        /// Check whether the specified text is mostly cyrillic
        /// </summary>
        /// <param name="text"></param>
        /// <returns></returns>
        public static bool IsCyrillic(string text)
        {
            int cyrillicCount = 0;
            int latinCount = 0;
            foreach(char ch in text)
            {
                if (ch <= '9') continue;

                if (ch <= 255)
                    latinCount++;
                else
                    cyrillicCount++;
            }
            return cyrillicCount > latinCount;
        }
        #endregion
    }
}
