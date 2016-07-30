%% This is file `ijsra.cls',
%%
%% LaTeX Class for ``International Journal of Student Research in Archaeology''.
%%
%% Copyright (C) 2016-
%% Lukas C. Bossert
%%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.

\listfiles
\NeedsTeXFormat{LaTeX2e}[1999/12/01]

\ProvidesClass{ijsra}
\RequirePackage{ifxetex,ifluatex,ifpdf,ifvtex}
\RequirePackage{xkeyval}

\def\IJSRAversion{0.1a}
\def\IJSRAversiondate{2016/07/28}



\newcommand*\IJSRAmonth{\scshape proof}
\newcommand*\IJSRAyear{\scshape proof}% \edef\issueyear{\the\year}
\newcommand*\IJSRAvolume{\scshape proof}
\newcommand*\IJSRAnumber{\scshape proof}
\newcommand*\IJSRAidentifier{\jobname}



\DeclareOptionX{draft}{\PassOptionsToClass{\CurrentOption}{scrbook}}
\DeclareOptionX{month}{\def\IJSRAmonth{#1}}
\DeclareOptionX{year}{\def\IJSRAyear{#1}}
\DeclareOptionX{volume}{\def\IJSRAvolume{Vol.\addspace #1}}
\DeclareOptionX{number}{\def\IJSRAnumber{No.\addspace #1}}
\DeclareOptionX*{\OptionNotUsed}
\ProcessOptionsX\relax


\RequirePackage{scrhack}% Andere Pakete KOMA-Script-freundlich machen


\LoadClass[%
	twoside=true,				% onesite or twoside printing
	open=right,					% doublepage cleaning ends up right side
	chapterprefix=false,		% prefix for chapter marks (Löscht "Kapitel" bei Kapitel)
	headings=optiontohead, 		% \chapter[tocentry={}]{}
	fontsize=11pt,				% font size
	titlepage=on,				% own page for each title page
	captions=tableabove,		% display table captions above the float env
	numbers=noenddot,
]{scrbook}%	


\RequirePackage{filecontents}
\RequirePackage{libertine}
\renewcommand*\ttdefault{lmvtt}
\RequirePackage[main=english]{babel}

\ifxetex\else
	\RequirePackage[%
	,protrusion=true
	,expansion=true
	,verbose=true
	,final=true
	,letterspace=100
	,babel=true
	]{microtype}
	\fi
\RequirePackage{colortbl}
\RequirePackage{abbrevs}
\RequirePackage{alertmessage}
\RequirePackage{marginnote}
\RequirePackage{lettrine} % The lettrine is the first enlarged letter at the beginning of the text
\RequirePackage{paralist} % Used for the compactitem environment which makes bullet points with less space between them
\RequirePackage{currfile}
\RequirePackage{currfile-abspath}


\RequirePackage[
detect-all, %Zahlen werden in der aktuellen Schrift angezeigt
	exponent-to-prefix  		= true,
	round-mode          		= places, 
	round-precision     		= 1,
	group-minimum-digits 	= 4, 		% Für "Tausenderpunkt" --> 1.234 anstatt 1234
	group-separator		={,},		% für "12.345" statt "12 345"
	range-phrase 			= {~$\times$\ },%
	zero-decimal-to-integer 	= true,	%aus "2.0" wird "2"
	range-units			=single, 	% --> 2 x 2 m, - auskommentieren für 2 m x 2 m
	]{siunitx} %Supreme typesetting of units
\RequirePackage[					% advanced quotes
	strict=true,					% 	- warning are errors now
	style=english,					% 	- german quotes
]{csquotes}
\RequirePackage[					%% use  for bibliography
	backend=biber,
	style=ijsra,
	]{biblatex}
\addbibresource{\jobname.bib}


\RequirePackage{etoolbox}
\RequirePackage{graphicx}
\RequirePackage{wrapfig} % Paket zur Positionierung einbinden
\RequirePackage{booktabs}%für schönere Tabellen
\RequirePackage{multirow}
\RequirePackage{xspace}
\RequirePackage{xcolor}

\definecolor{myblue}{rgb}{0,0,51}
\definecolor{mygold}{RGB}{204,153,51}

\definecolor{codeblue}{RGB}{0,65,137}
\definecolor{codegreen}{RGB}{147,193,26}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\RequirePackage{pdfpages}
%-----------------------------------------
\RequirePackage[					% page layout modifications
	paper=a4paper,				% 	- use A4 paper size
	head=4\baselineskip,			% 	- no header
	foot =4\baselineskip,
	bindingoffset=0.5cm,			% 	- binding correction
	top=3cm,						% 	- total body: top margin
	left=2cm,						% 	- total body: left margin (odd pages)
	right=5cm,					% 	- total body: right margin (odd pages)
	bottom=5cm,					% 	- total body: bottom margin
	marginparwidth=4cm,			% 	- width for side note
]{geometry}
\RequirePackage{multicol} % Used for the two-column layout of the document
\RequirePackage[%
	hang, 
	small,
	labelfont=bf,
	up,
	textfont=it,
	up,
	]{caption} % Custom captions under/above floats in tables or figures
\RequirePackage{subcaption}
\RequirePackage{setspace}			% for line spacing, e.g. \onehalfspacing
\RequirePackage{booktabs} % Horizontal rules in tables
\RequirePackage{float} % Required for tables and figures in the multi-column environment - they need to be placed in specific locations with the [H] (e.g. \begin{table}[H])
\RequirePackage{nth}

\RequirePackage{caption}
\RequirePackage{chngcntr} %Voraussetzung fuer Fussnoten durch alle Kapitel durchnummerieren
\RequirePackage{listings}
\AtBeginDocument{\counterwithin{lstlisting}{chapter}}

\counterwithout{footnote}{chapter} %Fussnoten durch alle Kapitel durchnummerieren
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}

%-------------------------------------------
\RequirePackage[ 
	headsepline, 
	draft=false,
	]{scrlayer-scrpage} 
\pagestyle{scrheadings}
\clearscrheadfoot

\lohead[\normalfont\sffamily\footnotesize International Journal of Student Research in Archaeology (IJSRA) \newline 
\normalfont\sffamily\footnotesize \IJSRAmonth\ \IJSRAyear\ $\bullet$ \IJSRAvolume, \IJSRAnumber \ppages]{\normalfont\sffamily\footnotesize \shorttitle\ \ppages}
\rehead{\normalfont\sffamily\footnotesize \shortauthor}
\rohead[{{\vspace{-3em}\includegraphics[width=2cm]{ijsra_logo}}}]{\normalfont\textbf{\sffamily\thepage}}
\lehead{\normalfont\textbf{\sffamily\thepage}}
\refoot{\normalfont\sffamily\footnotesize International Journal of Student Research in Archaeology}
\lofoot{\normalfont\sffamily\footnotesize \IJSRAmonth\ \IJSRAyear\ $\bullet$ \IJSRAvolume, No. \IJSRAnumber}
\automark[subsection]{section}  

%-----------------------------
\setkomafont{partnumber}{\normalfont\Huge}
\setkomafont{part}{\normalfont\scshape\Huge}
\setkomafont{chapter}{\normalfont\LARGE}%\uppercase
\setkomafont{section}{\normalfont\Large}%\uppercase
\setkomafont{subsection}{\normalfont}%\uppercase
\setkomafont{subsubsection}{\normalfont}%\uppercase
\setkomafont{paragraph}{\normalfont\scshape}%\uppercase
\addtokomafont{descriptionlabel}{\normalfont\sffamily}%\textsf\large}%\uppercase
\addtokomafont{sectioning}{\linespread{1}\selectfont} %einfacher Zeilenabstand in Überschriften
\addtokomafont{headsepline}{\color{mygold}}
\addtokomafont{labelinglabel}{\sffamily\bfseries}

\setfootnoterule{0pt}

\addtolength{\skip\footins}{.5\baselineskip} % Abstand Text <->
\KOMAoptions{headsepline=3pt}

\clubpenalty=10000				% prevent single lines at the beginning of a paragraph (Schusterjungen)
\widowpenalty=10000				% prevent single lines at the end of a paragraph (Hurenkinder)
\displaywidowpenalty=10000		%
%-----------------------------------------
\usepackage[%
	marginal,
	ragged,%
	hang, %
	bottom%
	]{footmisc} %Fussnoten
\raggedbottom

\deffootnote{0em}{1em}{{\sffamily\textbf\thefootnotemark}\ }%Ausgabe der Fußnotenziffer in normal
%--------------------------------------
\robustify{\DateMark} % after having loaded abbrevs


\ifstr{\KOMAScriptVersion}{2015/07/02 v3.18 KOMA-Script}{%
  \ifx\par@update\default@par@update\else
    \AtBeginDocument{\par@updaterelative}%
  \fi
}{}

\renewcommand{\marginfont}{%
	\normalfont\small\sffamily}
%-------------------------------------------
%---Zitate/Quote
\def\signed #1{\leavevmode\unskip\nobreak\hfil\penalty50\hskip2em
	\hbox{}\nobreak\hfil%
	---#1%
	\parfillskip=0pt \finalhyphendemerits=0 \endgraf}

\newsavebox\mybox
\newenvironment{IJSRAquote}[1]%
{\savebox\mybox{#1}\begin{quote}}
	{\signed{\usebox\mybox}\end{quote}}

\makeatletter %%%Schriftgröße in quote kleiner
\newif\if@in@footnote@
\renewcommand{\@footnotetext}[1]{%
	\scr@saved@footnotetext{\@in@footnote@true #1}%
	\csname FN@mf@prepare\endcsname
}
\AtBeginEnvironment{quote}{\if@in@footnote@\else\small\fi}
\makeatother
%-----------------------------------------
\newcommand\ppages{\pagerange{firstpage\IJSRAidentifier}{lastpage\IJSRAidentifier}}
\newcommand\shorttitle{}
\newcommand\maintitle{}
\newcommand\shortauthor{}
\newcommand\authormail{}
\newcommand\affiliation{}
\newcommand\thanknote{}
\def\keywords{}
\def\keywordname{Keywords}

\newenvironment{IJSRAabstract}
{\list{}{\rightmargin\leftmargin}%
\item \normalsize\sffamily\textbf\keywordname :  \keywords\\
	\footnotesize\itshape
	\noindent\item\relax
	}
{\endlist}

\newcommand{\IJSRAseparator}{
	\vspace{2em}
	\begin{center}
		* * *
	\end{center}
	\vspace{2em}}

\newcommand{\IJSRAchapter}[1]{
	\setcounter{chapter}{1}
	\chapter*{#1}
	\addcontentsline{toc}{chapter}{\shortauthor\protect\newline \maintitle}
}
	
\newcommand\email{{\normalfont\href{mailto:\authormail}{\authormail}}}

\newbool{@page}
\newcommand{\pagerange}[2]{%pp.~
	\edef\tempa{\getpagerefnumber{#1}\booltrue{@page}}%
	\edef\tempb{\getpagerefnumber{#2}}%
	\ifboolexpr{bool{@page}}{}{\ $\bullet$ 
		\tempa--\tempb}}


\providecommand\IJSRAopening{%
	\begin{refsection}
	\setcounter{footnote}{0}
	\setcounter{table}{0}
	\setcounter{figure}{0}
	\renewcommand*{\thefootnote}{\fnsymbol{footnote}}
	\IJSRAchapter{\maintitle}
	\begin{center}
	}
	
\providecommand\IJSRAmid{%
	\end{center}
	\vspace{3em}
	\pagestyle{scrheadings}	
	\setcounter{footnote}{0}
	\renewcommand*{\thefootnote}{\arabic{footnote}}
	\label{firstpage\IJSRAidentifier}
	}
	
\providecommand\IJSRAclosing{%
	\printbibliography[heading=subbibliography] 
	\end{refsection}
	\label{lastpage\IJSRAidentifier}
}

 \DeclareCaptionFormat{listing}{#1#2#3}
 \captionsetup[lstlisting]{format=listing,%
 			 singlelinecheck=false, 
 			 margin=0pt, 
 			 font={sf},
 			 size=footnotesize}
 


\renewcommand{\lstlistingname}{Example}%rename caption
\renewcommand{\lstlistlistingname}{List of examples}%rename caption


\lstdefinestyle{code}{%
	language=[LaTeX]TeX,
    backgroundcolor=\color{backcolour},   
    commentstyle=\color{codegreen},
    keywordstyle=\color{codeblue},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    escapeinside={*@}{@*},          % if you want to add LaTeX within your code
    texcsstyle=*\color{codeblue},
    morekeywords={cites, parencites, parencite, textcite, textcites, citeauthor, citetitle,@String,
    						@Article, @Book,@Collection,@Proceedings,@Reference,@Thesis,
    						@Inproceedings,@Talk,@Review,@Inreference,@Incollection,
    						},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,         
    breaklines=true,   
    numberbychapter=false,   
    captionpos=b,                    
    keepspaces=true,               
	%framexleftmargin=5mm, 
	%frame=shadowbox,
	rulesepcolor=\color{codeblue},
    numbers=left,                    
    numbersep=5pt,            
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=2,
    literate=
            *{\{}{{{\color{codegreen}{\{}}}}{1}
            {\}}{{{\color{codegreen}{\}}}}}{1}
            {[}{{{\color{codegreen}{[}}}}{1}
            {]}{{{\color{codegreen}{]}}}}{1},
}


\lstset{style=code}
%\lstMakeShortInline[style=code]|
%


%------------------------------------

\RequirePackage{hyperref} % For hyperlinks in the PDF
\hypersetup{					% setup the hyperref-package options
	colorlinks   = true, %Colours links instead of ugly boxes
	urlcolor     =  myblue, %Colour for external hyperlinks
	linkcolor    = myblue, %Colour of internal links
	citecolor   = myblue, %Colour of citations
	linktoc=page,
	pdfborder={0 0 0},			% 	-
	breaklinks=true,			% 	- allow line break inside links
	bookmarksnumbered=true,		%
	bookmarksopenlevel=2,
	bookmarksopen=true,		%
	final=true	% = true, only with web-Documents!!
}

\RequirePackage{cleveref}


\endinput