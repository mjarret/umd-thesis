\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{umd-thesis}[10/08/2015 University of Maryland Thesis]

% Redefine Chapter formatting
\LoadClassWithOptions{thesis}
\RequirePackage{titlesec}
	\titleformat{\chapter}
      {\normalfont\large}{Chapter \thechapter:}{1em}{}


%%%%%%    Document Layout
%
%% Default line spacing: double space
%
\RequirePackage{setspace}
	\doublespacing
%
%% Page layout (see The LaTeX Companion pp.84-86).
%
%% By default, TeX puts the ``reference point'' one inch down and to
%% the right of the top-left corner of the page.  This moves it back
%% to the top-left corner (making the rest of the layout easier to
%% define).
%
\setlength{\voffset}{-1in}
\setlength{\hoffset}{-1in}
%
%% Instead of hard-coding the page layout for letter paper
%% (8.5" x 11"), we will base it on \paperheight and \paperwidth,
%% so that it works with options that change the paper size.
%
\setlength{\textheight}{\paperheight}
\setlength{\textwidth}{\paperwidth}
%
%% Now, set the margin-dependent values.
%
\addtolength{\textheight}{-2.5in}
\setlength{\topmargin}{0.75in}
\setlength{\headsep}{0.75in}   % reduced by headheight, below
\setlength{\footskip}{0.5in}
\addtolength{\textwidth}{-2.5in}
\setlength{\oddsidemargin}{1.5in}
\setlength{\evensidemargin}{1in}
\setlength{\marginparwidth}{.75in}
\setlength{\marginparsep}{.125in}
%
%% Adjust \headsep to include height of running head.
%
\addtolength{\headsep}{-\headheight}
%


% Set various depths of tables
\setcounter{tocdepth}{3} % Table of contents has depth 3

%%%%%%%%%%%%%% Initialize local variables
%
%% default values of private functions
%
\def\@title{}
\def\@author{}
\def\@bibfiles{}
\def\@principaladvisor{}
\def\@coadvisor{}
\def\@committeechair{}
\def\@firstreader{}
\def\@secondreader{}
\def\@thirdreader{}
\def\@fourthreader{}
\def\@fifthreader{}
\def\@sixthreader{}


%%%%%%    Front Matter Parameters
%
%% The following commands set the respective field values so we
%% can generate the title page, signature page, and abstract
%% page automatically
%
\renewcommand{\author}[1]%
  {\ifx\empty#1\empty\else\gdef\@author{#1}\fi}
\renewcommand{\title}[1]%
  {\ifx\empty#1\empty\else\gdef\@title{#1}\fi}

\newcommand{\degree}[1]%
  {\ifx\empty#1\empty\else\gdef\@degree{#1}\fi}
  
\newcommand{\department}[1]%
  {\ifx\empty#1\empty\else\gdef\@department{#1}\gdef\@dept{#1}\fi}

\newcommand{\gradyear}[1]%
  {\ifx\empty#1\empty\else\gdef\@gradyear{#1}\gdef\@copyrightyear{#1}\fi} 
 
%%%%% The following local switches are used throughout  
%
%% Is there a coadvisor?
%
\newif\ifhavecoadvisor
\havecoadvisorfalse % set to false by default
% 
%%  Is advisor also chair?
%
\newif\if@advisorchair
\@advisorchairtrue % set to true by default

%
%% Is coadvisor also chair?
%
\newif\if@coadvisorchair
\@coadvisorchairfalse % set to false by default
%
%% Is there a different chair entirely?
%
\newif\ifotherchair
\otherchairfalse % set to false by default 
%
%% Switch for printing copyright page
%
\newif\ifcopyright
\copyrighttrue % initially true by default
%% Switch for generating a list of figures
%
\newif\iffigurespage
\figurespagetrue % initially true by default

%% Switch for generating a list of tables
%
\newif\iftablespage
\tablespagetrue % initially true by default

%% Switch for generating a table of contents
%
\newif\ifcontentspage
\contentspagetrue % initially true by default

%% Switch for generating a bibliography
%
\newif\ifbibpage
\bibpagetrue % initially true by default


% Define \principaladvisor{} to take two optional arguments after the
% name. Thus, the usage is 
%    \principaladvisor{Advisor Name}[Advisor Unit][Advisor Institution]
% Advisor Unit defaults to \@department and Advisor Institution
% defaults to Georgia Institute of Technology.
\newcommand{\principaladvisor}[1]{%
  \@ifnextchar[{\principaladvisor@i{#1}}{\principaladvisor@i{#1}[\@department]}%]
}
\def\principaladvisor@i#1[#2]{%
  \@ifnextchar[{\principaladvisor@ii{#1}[#2]}{\principaladvisor@ii{#1}[#2][University of Maryland, College Park]}%]
}
\def\principaladvisor@ii#1[#2][#3]{%
\ifx\empty#1\empty\else\def\@advisorforabstract{#1 \\ #2}\fi
\ifx\empty#1\empty\else\def\@advisorname{#1}\fi	
}          



% Define \coadvisor{} to take two optional arguments after the
% name. Thus, the usage is 
%    \principaladvisor{Advisor Name}[Advisor Unit][Advisor Institution]
% Advisor Unit defaults to \@department and Advisor Institution
% defaults to University of Maryland.
\newcommand{\coadvisor}[1]{%
  \havecoadvisortrue
  \@ifnextchar[{\coadvisor@i{#1}}{\coadvisor@i{#1}[\@department]}%]
}
\def\coadvisor@i#1[#2]{%
  \@ifnextchar[{\coadvisor@ii{#1}[#2]}{\coadvisor@ii{#1}[#2][University of Maryland, College Park]}%]
}
\def\coadvisor@ii#1[#2][#3]{%
\ifx\empty#1\empty\else\def\@coadvisorname{#1}\fi
}        

% Command to make Co-Advisor into Chair
\newcommand{\coadvisorischair}{
	\@advisorchairfalse%
	\@coadvisorchairtrue%
}

%
%% Committee Chair
%
% Define \committeechair{} to take two optional arguments after the
% name. Thus, the usage is 
%    \committeechair{Name}[Unit][Institution]
% Unit defaults to \@department and Institution defaults to Georgia
% Institute of Technology.
\newcommand{\committeechair}[1]{%
  \@advisorchairfalse%
  \@otherchairtrue%
  \@ifnextchar[{\committeechair@i{#1}}{\committeechair@i{#1}[\@department]}%]
}
\def\committeechair@i#1[#2]{%
  \@ifnextchar[{\committeechair@ii{#1}[#2]}{\committeechair@ii{#1}[#2][University of Maryland, College Park]}%]
}
\def\committeechair@ii#1[#2][#3]{%
\ifx\empty#1\empty\else\def\@chairname{#1}%
    \fi
}          

%
%% readers
%
% Define \{first|second|third|fourth|fifth|sixth}reader{} to take two
% optional arguments after the name. Thus, the usage is 
%    \*reader{Reader Name}[Reader Unit][Reader Institution]
% Reader Unit defaults to \@department and Reader Institution
% defaults to Georgia Institute of Technology.
\newcommand{\firstreader}[1]{%
  \@ifnextchar[{\firstreader@i{#1}}{\firstreader@i{#1}[\@department]}%]
}
\def\firstreader@i#1[#2]{%
  \@ifnextchar[{\firstreader@ii{#1}[#2]}{\firstreader@ii{#1}[#2][University of Maryland, College Park]}%]
}
\def\firstreader@ii#1[#2][#3]{%
\ifx\empty#1\empty\else\def\@firstname{#1}%	
}          

\newcommand{\secondreader}[1]{%
  \@ifnextchar[{\secondreader@i{#1}}{\secondreader@i{#1}[\@department]}%]
}
\def\secondreader@i#1[#2]{%
  \@ifnextchar[{\secondreader@ii{#1}[#2]}{\secondreader@ii{#1}[#2][University of Maryland, College Park]}%]
}
\def\secondreader@ii#1[#2][#3]{%
\ifx\empty#1\empty\else\def\@secondname{#1}%	
}          

\newcommand{\thirdreader}[1]{%
  \@ifnextchar[{\thirdreader@i{#1}}{\thirdreader@i{#1}[\@department]}%]
}
\def\thirdreader@i#1[#2]{%
  \@ifnextchar[{\thirdreader@ii{#1}[#2]}{\thirdreader@ii{#1}[#2][University of Maryland, College Park]}%]
}
\def\thirdreader@ii#1[#2][#3]{%
\ifx\empty#1\empty\else\def\@thirdname{#1}%	
}          

\newcommand{\fourthreader}[1]{%
  \@ifnextchar[{\fourthreader@i{#1}}{\fourthreader@i{#1}[\@department]}%]
}
\def\fourthreader@i#1[#2]{%
  \@ifnextchar[{\fourthreader@ii{#1}[#2]}{\fourthreader@ii{#1}[#2][University of Maryland, College Park]}%]
}
\def\fourthreader@ii#1[#2][#3]{%
\ifx\empty#1\empty\else\def\@fourthname{#1}%	
}          

\newcommand{\fifthreader}[1]{%
  \@ifnextchar[{\fifthreader@i{#1}}{\fifthreader@i{#1}[\@department]}%]
}
\def\fifthreader@i#1[#2]{%
  \@ifnextchar[{\fifthreader@ii{#1}[#2]}{\fifthreader@ii{#1}[#2][University of Maryland, College Park]}%]
}
\def\fifthreader@ii#1[#2][#3]{%
\ifx\empty#1\empty\else\def\@fifthname{#1}%	
}          

\newcommand{\sixthreader}[1]{%
  \@ifnextchar[{\sixthreader@i{#1}}{\sixthreader@i{#1}[\@department]}%]
}
\def\sixthreader@i#1[#2]{%
  \@ifnextchar[{\sixthreader@ii{#1}[#2]}{\sixthreader@ii{#1}[#2][University of Maryland, College Park]}%]
}
\def\sixthreader@ii#1[#2][#3]{%
\ifx\empty#1\empty\else\def\@sixthname{#1}%	
}



%%%%%% Make Copyright Page %%%%%%%%%%%
\newcommand{\makecopyright}{
  \typeout{*****************      Copyright     ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 
  \addtocounter{page}{-1} 

\thispagestyle{empty}
\hbox{\ }

\vfill
\singlespacing
\small\normalsize

\vspace{-.65in}

\begin{center}
\large{\copyright \hbox{ }Copyright by\\
\@author 
\\
\@gradyear }
\end{center}

\vfill
}

\renewcommand{\maketitle}{
  \typeout{*****************      TITLE     ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 
  \pagenumbering{gobble}
  \addtocounter{page}{-1} 
  \thispagestyle{empty}%

\hbox{\ }

\thispagestyle{empty}
\hbox{\ }
\vspace{1in}
\singlespacing
\small\normalsize
\begin{center}

\large{\MakeUppercase{\@title}}\\
\ \\
\ \\
\large{by} \\
\ \\
\large{\@author}
\ \\
\ \\
\ \\
\ \\
\normalsize
Dissertation submitted to the Faculty of the Graduate School of the \\
University of Maryland, College Park in partial fulfillment \\
of the requirements for the degree of \\
\@degree \\
\@gradyear
\end{center}

\vspace{7.5em}

\begin{flushleft}
	Advisory Committee: \\
	\if@advisorchair{\@advisorname , Chair/Advisor
		\ifhavecoadvisor{\\ \@coadvisorname, Co-Advisor}\fi
	}\fi 
	\if@coadvisorchair{\@coadvisorname, Chair/Co-Advisor \\
	\@advisorname, Advisor	
	}\fi
	\ifotherchair{\@chairname , Chair \\
		\@advisorname , Advisor \\
		\ifhavecoadvisor{\@coadvisorname , Co-Advisor}}\fi 
	\fi
	\ifdefined\@firstname{\\ \@firstname}\fi
	\ifdefined\@secondname{\\ \@secondname}\fi
	\ifdefined\@thirdname{\\ \@thirdname}\fi
	\ifdefined\@fourthname{\\ \@fourthname}\fi
 	\ifdefined\@fifthname{\\ \@fifthname}\fi
	\ifdefined\@sixthname{\\ \@sixthname}\fi 
\end{flushleft}
}%maketitle

 
%
%% Change \begin{abstract}...\end{abstract} to follow guidelines
%% and put the abstract on a separate page (checking @openright).
%
\renewenvironment{abstract}{%
  \typeout{*****************      Abstract     ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 
  \addtocounter{page}{-1} 
  \thispagestyle{empty}%

\hbox{\ }

\singlespacing
\small \normalsize
\begin{center}
\large{{ABSTRACT}} 

\vspace{3em} 

\end{center}

\noindent \begin{minipage}[t]{0.3\textwidth} 
	\begin{flushleft} 
		Title of dissertation:
	\end{flushleft}	
\end{minipage}    \hspace{.3em}
\begin{minipage}[t]{0.7\textwidth}
	\begin{flushleft}
		{\large\MakeUppercase{\@title}} \\ \ \\
		{\large\@author, \@degree, \@gradyear} 
	\end{flushleft}
\end{minipage}

\ \\

\noindent \begin{minipage}[t]{0.3\textwidth}
	\begin{flushleft}
		Dissertation directed by:
	\end{flushleft}	
\end{minipage} \hspace{.3em}
\begin{minipage}[t]{0.7\textwidth}
	\large\@advisorforabstract
\end{minipage}

\vspace{3em}

\doublespacing
\large \normalsize

  \begingroup%
 %   \hspace*{2.5em}%
    %% Adjust the line spacing: if it was less than 1 1/2,
    %% increase it to 1 1/2; if it was between 1 1/2 and 2,
    %% increase it to 2; otherwise, leave it as is.
  %  \ifdim \baselinestretch pt < 1.25pt \newlinestretch{1.25}\else%
   % \ifdim \baselinestretch pt < 1.66pt \newlinestretch{1.66}\fi\fi%
}{\par\endgroup}%abstract
%

%
%% \begin{dedication}...\end{dedication} formats a
%% dedication section
%
\newcommand{\dedicationtop}{\vspace*{\stretch{1}}}
\newcommand{\dedicationbottom}{\bigskip\bigskip\vspace*{\stretch{1}}}
\newenvironment{dedication}{%
  \typeout{*****************    Dedication    ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 

\doublespacing
\small\normalsize
\hbox{\ }
 
\vspace{-.65in}

\addcontentsline{toc}{chapter}{Dedication}

\begin{center}
\large{Dedication}
\end{center} 

\begingroup
}{\par \endgroup}%dedication

\newenvironment{foreword}{%
  \typeout{*****************    FOREWORD    ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 
%  \phantomsection%
%  \addcontentsline{toc}{chapter}%
  %Dedication

%Dedication

\doublespacing
\small\normalsize
\hbox{\ }
 
\vspace{-.65in}

\addcontentsline{toc}{chapter}{Foreword}

\begin{center}
\large{Foreword} 
\end{center} 

\begingroup
}{\par \endgroup}%dedication




%
%% \begin{acknowledgements}...\end{acknowledgements} formats an
%% acknowledgements section
%
\newenvironment{acknowledgements}{%
  \typeout{***************** Acknowledgements ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 
\doublespacing
\small\normalsize
\hbox{\ }
 
\vspace{-.65in}

\addcontentsline{toc}{chapter}{Acknowledgements}

\begin{center}
\large{Acknowledgments} 
\end{center} 

\vspace{1ex}

  \begingroup
}{\par\endgroup}%Acknowledgements
%
%% \begin{preface}...\end{preface} formats an
%% preface section
%
\newenvironment{preface}{%
  \typeout{*****************      Preface     ******************}
  \if@openright\cleardoublepage\else\clearpage\fi 
\doublespacing
\small\normalsize
\hbox{\ }
 
\vspace{-.65in}

\addcontentsline{toc}{chapter}{Preface}

\begin{center}
\large{Preface} 
\end{center} 

  \begingroup
}{\par\endgroup}%preface


%%%%%%    New formatting environments and commands.
%
%% \begin{preliminary} sets the pagestyle and pagenumbering 
%% (roman numeral format ) for the preliminary sections.
%%
%% \end{preliminary} resets the pagenumbering. To start page 
%% numbering in arabic format, use \pagestyle{plain} and 
%% \pagenumbering{arabic} after the preliminary environment block
%
\newenvironment{preliminary}%
  {  
    \pagenumbering{gobble}
      \maketitle
		\ifcopyright
			\makecopyright
		\fi
    \pagenumbering{roman}
    \setcounter{page}{1}
  }%
  {%
  
  	\ifcontentspage
  		\tableofcontents
  	\fi
  	\newpage
	\setlength{\parskip}{0em}
	\doublespacing
	\small\normalsize
    \pagenumbering{arabic}
  }%
  
% Hack to make sure that each chapter starts on a new page.
\let\stchapter\chapter
\renewcommand{\chapter}{\clearpage\stchapter}

% Hack to define the bibliography style
\let\stbibliography\bibliography
\renewcommand{\bibliography}{\singlespacing \small\normalsize \stbibliography}
