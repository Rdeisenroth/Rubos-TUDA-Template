\def\fileversion{1.4.2}
\def\filedate{2022/04/18}

% Sets the LaTeX version for the package to work.
\NeedsTeXFormat{LaTeX2e}
% Identification of the class and its date and version.
\ProvidesExplClass{rubos-tuda-template}{\filedate}
{\fileversion}{LaTeX Vorlage für Hausübungen, Zusammenfassungen und Abgaben basierend auf TuDaExercise}

% Made by Ruben Deisenroth, 2022
% Available at https://github.com/Rdeisenroth/TUDA-Hausuebungstemplate/blob/main/rubos-tuda-template.cls
\RequirePackage[minted_workaround,caption_workaround]{rubos-common}
% Packages that need to be loaded before TUDA-Exercise Class
\RequirePackage[table, dvipsnames]{xcolor} % Option has to be set before loading TuDaExercise
\RequirePackage{pagecolor} % Used for dark Mode
\PassOptionsToPackage{bookmarksnumbered}{hyperref} % Nummerierte Bookmarks
\PassOptionsToPackage{no-math}{fontspec}
\definecolor{rubos@anthrazitgrau}{HTML}{293133}
\RequirePackage{scrlfile}
% Wir müssen imakeidx vor Hyperref laden, damit das Stichwortverzeichnis hyperlinks hat
\AfterClass{scrartcl}{
    \RequirePackage{imakeidx}
    \RequirePackage{xr-hyper}
}

\bool_gset_false:N \g_manual_term_bool
\bool_gset_false:N \g_is_summary_bool
\bool_gset_false:N \g_is_main_file_bool
\bool_gset_false:N \g_is_submission_bool
\bool_gset_false:N \g_ptxcd_ex_load_common_bool
\bool_gset_true:N \g_ptxcd_ex_fancy_rowcolor_bool
\tl_gclear_new:N \datename
\tl_gset:Nn \datename {Datum}

\tl_gclear_new:N \g_rubos_keys_tl
\tl_gset:Nn \g_rubos_keys_tl {
    boxarc .code:n = \PassOptionsToPackage{\CurrentOption}{rubos-common},
    dark_mode .code:n = \PassOptionsToPackage{\CurrentOption}{rubos-common},
    manual_term .bool_gset:N = \g_manual_term_bool,
    manual_term .initial:n = false,
    manual_term .default:n = true,
    summary .code:n = \bool_if:nTF \g_is_submission_bool {\ClassError{rubos-tuda-template}{summary~can't~be~used~with~submission~mode~enabled}{disable~submission~mode}}{\bool_gset_true:N \g_is_summary_bool\tl_gset:Nn \datename {Stand}},
    submission .code:n = \bool_if:nTF \g_is_summary_bool{\ClassError{rubos-tuda-template}{submission~can't~be~used~with~summary~mode~enabled}{disable~summary~mode}}{\bool_gset_true:N \g_is_submission_bool},
    load_common .bool_gset:N = \g_ptxcd_ex_load_common_bool,
    load_common .initial:n = false,
    load_common . default:n = true,
    fancy_row_color .code:n = \PassOptionsToPackage{\CurrentOption}{rubos-common},
    shell_escape .code:n = \PassOptionsToPackage{\CurrentOption}{rubos-common},
    main .code:n = \PassOptionsToPackage{\CurrentOption}{rubos-common},
    requireid .bool_gset:N = \g_rubos_require_id_bool,
    requireid .initial:n = false,
    requireid .default:n = true,
}
% Additional Class Options
\exp_args:Nno \keys_define:nn {ptxcd/exercise} { \g_rubos_keys_tl }
% Compatibility with older versions (We can't use version check makros before loading the class)
\exp_args:Nno \keys_define:nn {TUDa/pub} { \g_rubos_keys_tl }

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tudaexercise}}
\ProcessOptions\relax
% \ProcessKeyvalOptions{boxarc}\relax
\LoadClass[
    %fontsize= 12pt,
    a4paper,
    marginpar=false,
    colorback=false,
    points=true,
    leqno,
    fleqn,
    footsepline=.5pt,
    T1,
]{tudaexercise}

% Packages
\RequirePackage{amsmath}
\RequirePackage[ngerman]{babel}
\RequirePackage{amsthm}
\RequirePackage{booktabs}
\RequirePackage[font=small, labelfont=sc, position=bottom]{caption}
\RequirePackage[labelfont=normalfont, position=bottom]{subcaption}
\RequirePackage{csquotes}
\PassOptionsToPackage{inline}{enumitem}
\RequirePackage{enumitem}
\RequirePackage{mathtools}
\RequirePackage{silence}
% \RequirePackage{amssymb}
% \RequirePackage[T1]{fontenc}
\WarningFilter[sillyfonterror]{latex}{Font~shape~declaration~has}
\ActivateWarningFilters[sillyfonterror]
\ifLuaTeX
    % Fix Font warnings for mathdesign
    \DeclareFontFamily{TU}{mdbch}{}
    \DeclareFontShape{TU}{mdbch}{m}{n}{
        <-> \UnicodeFontFile{lmroman10-regular}{\UnicodeFontTeXLigatures}
    }{}
    \RequirePackage[utf8]{luainputenc} % if problems with ß exist
\fi
\RequirePackage[charter, cal=cmcal]{mathdesign}
\RequirePackage{XCharter}
\DeactivateWarningFilters[sillyfonterror]
% \RequirePackage{mathrsfs} % We use Charter instead
\RequirePackage{tcolorbox}
\tcbuselibrary{skins}
\csname sys_if_shell_unrestricted:T\endcsname{\bool_if:NT \g_rubos_shell_escape_bool {\tcbuselibrary{minted}}}
\RequirePackage{listings}
\RequirePackage{totcount}
\regtotcounter{task}
\RequirePackage{wrapfig}
\RequirePackage{refcount}

% Strings/Names
\defcaptionname*{ngerman, german}{\solutionname}{Lösung}


% --Helper Commands--


% \newcommand{\loadcommon}{
\bool_if:NT \g_ptxcd_ex_load_common_bool {
    % \pagecolor{black}\color{white}
    \RequirePackage[export]{adjustbox}
    % \RequirePackage{amssymb} % We use charter instead
    \RequirePackage{blindtext}
    \RequirePackage{bm}
    \RequirePackage{colortbl}
    % \RequirePackage{cryptocode}
    % \RequirePackage[utf8]{inputenc} % Has to be loaded before csquotes
    \RequirePackage{ebproof}
    \RequirePackage{etoolbox}
    % \RequirePackage[T1]{fontenc}
    \RequirePackage{forest}
    \RequirePackage{fontawesome}
    \RequirePackage{framed}
    \RequirePackage{import}
    % \RequirePackage[utf8]{inputenc} % Already loaded before cs quotes
    \RequirePackage{karnaughmap}
    \RequirePackage{latexsym}
    \RequirePackage{longtable}
    \RequirePackage{makecell}
    \RequirePackage[framemethod=tikz]{mdframed}
    \RequirePackage{mleftright}
    \RequirePackage[longtable]{multirow}
    \RequirePackage{nccmath}
    \RequirePackage{pageslts}
    \pagenumbering{arabic}
    \RequirePackage{placeins}
    \RequirePackage{pgfplots}
    \pgfplotsset{compat=1.17}
    \RequirePackage{proof}
    \RequirePackage{qtree}
    \RequirePackage{ragged2e}
    \RequirePackage{stackengine}
    \RequirePackage{standalone}
    \RequirePackage{tabularx}
    \RequirePackage{tagging}
    \RequirePackage{tikz}
    \ExplSyntaxOff % Tikz doesn't Like Expl3 :/
    \usetikzlibrary{3d, angles, animations, arrows, arrows.meta, arrows.spaced, automata, babel, backgrounds, bending, calc, calendar, chains, circuits.ee.IEC, circuits.logic.CDH, circuits.logic.IEC, circuits.logic.US, datavisualization, datavisualization.formats.functions, datavisualization.polar, decorations, decorations.footprints, decorations.fractals, decorations.markings, decorations.pathmorphing, decorations.pathreplacing, decorations.shapes, decorations.text, er, external, fadings, fit, fixedpointarithmetic, folding, fpu, graphs, graphs.standard, intersections, lindenmayersystems, math, matrix, patterns, patterns.meta, perspective, petri, plotmarks, positioning, quotes, rdf, scopes, shadings, shadows, shadows.blur, shapes, shapes.arrows, shapes.callouts, shapes.gates.logic.IEC, shapes.gates.logic.US, shapes.geometric, shapes.misc, shapes.multipart, shapes.symbols, spy, svg.path, through, tikzmark, topaths, trees, turtle, views}
    \RequirePackage{tikz-qtree}
    \ExplSyntaxOn
    \RequirePackage[color=accentcolor,textcolor=white,textwidth=.8cm,textsize=small,loadshadowlibrary]{todonotes}
    % \RequirePackage{tikz-uml}
    \RequirePackage{xifthen}
}
% }
% \loadcommon{}

% Discover tudaci-Version
\exp_args:NNnx \seq_set_split:Nnn \g_tuda_version_seq { ~ } { \use:c {ver@tudaexercise.cls} }
\tl_set:Nx \g_tudaci_version_tl { \seq_item:Nn \g_tuda_version_seq { 2 } }
\tl_set:Nx \g_tudaci_version_tl {\tl_tail:N \g_tudaci_version_tl}
\regex_replace_once:nnN { [a-z] } { } \g_tudaci_version_tl

\newcommand{\getTudaciVersion}[1]{
    \tl_use:N \g_tudaci_version_tl
}
\cs_generate_variant:Nn \fp_set:Nn { Nx }
\newcommand{\IfTudaciVersionAtLeastTF}[3]{
    \fp_compare:nTF {\getTudaciVersion{} >= #1}{#2}{#3}
}
\newcommand{\IfTudaciVersionBetweenTF}[4]{
    \fp_compare:nTF {#1<=\getTudaciVersion{}<=#2}{#3}{#4}
}

% Term Creation (Information Area below the Title, depreceated)
\newcommand*{\maketerm}{%
    \term{%
        \begin{minipage}[t]{.5\textwidth}%
            \printFachbereich{}\\
            \printDozent{}%
        \end{minipage}%
        \begin{minipage}[t]{.49\textwidth}%
            \raggedleft%
            \begin{flushright}%
                \printSemester{}\\
                \printVersion{}
            \end{flushright}
        \end{minipage}
        \vspace{3ex}\\
        \printTopic{}\\
        \printSlides{}\\
        \printTotalPoints{}\\
        \printDueDate{}
    }
}

\IfTudaciVersionAtLeastTF{3.13}{
    \tl_gclear_new:N \g__ptxcd_task_properties_collector_tl
    \tl_gclear_new:N \g__ptxcd_task_properties_loaded_tl

    \DeclareDocumentEnvironment{task}{om}{
        \IfNoValueF{#1}{\keys_set:nn {ptxcd/task}{#1}}
        \@task{#2}
        \bool_if:NF \l__ptxcd_points_auto_bool {
            \cs_if_exist_use:NF \prop_gput:Nxx
            {\exp_args:NNx \prop_gput:Nnx}
            \g__ptxcd_points_collector_prop
            {\thetask} {\fp_to_decimal:N \l_ptxcd_ex_task_points_fp}
        }
    }{
        % Store Task Properties (since we don't want to overwrite the subtask property, we have to set each one manually)
        \tl_clear_new:N \l__ptxcd_task_properties_collector_tl
        \tl_set_eq:NN \l__ptxcd_task_properties_collector_tl \g__ptxcd_task_properties_collector_tl
        \rubos_prop_nested_set:Nxx \l__ptxcd_task_properties_collector_tl {\the\value{task}, title} {\tl_to_str:n {#2}}
        \rubos_prop_nested_set:Nxx \l__ptxcd_task_properties_collector_tl {\the\value{task}, thetask} {\exp_args:Ne\tl_to_str:n{\thetask}}
        \rubos_prop_nested_set:Nxx \l__ptxcd_task_properties_collector_tl {\the\value{task}, taskformat} {\exp_args:Ne\tl_to_str:n{\taskformat}} % We expand here, to account for thinks like a per task \thetask{} command
        \rubos_prop_nested_set:Nxx \l__ptxcd_task_properties_collector_tl {\the\value{task}, credit} {\tl_to_str:N \l_ptxcd_ex_task_credit_tl}
        \rubos_prop_nested_set:Nxx \l__ptxcd_task_properties_collector_tl {\the\value{task}, pointsauto} {\bool_if:NTF \l__ptxcd_points_auto_bool {true} {false}}
        \rubos_prop_nested_set:Nxx \l__ptxcd_task_properties_collector_tl {\the\value{task}, points} {\bool_if:NTF \l__ptxcd_points_auto_bool {\fp_use:N \g__ptxcd_ex_collected_points_fp} {\fp_use:N \l_ptxcd_ex_task_points_fp}}
        \rubos_prop_nested_set:Nxx \l__ptxcd_task_properties_collector_tl {\the\value{task}, solution} {\bool_if:NTF \l_ptxcd_ex_solution_bool {true}{false}}
        \tl_gset_eq:NN \g__ptxcd_task_properties_collector_tl \l__ptxcd_task_properties_collector_tl

        % a
        \bool_if:NT \l__ptxcd_points_auto_bool {
            \cs_if_exist_use:NF \prop_gput:Nxx
            {\exp_args:NNx \prop_gput:Nnx}
            \g__ptxcd_points_collector_prop
            {\thetask} {\fp_to_decimal:N \g__ptxcd_ex_collected_points_fp}
            \fp_gzero:N \g__ptxcd_ex_collected_points_fp
        }
    }

    \DeclareDocumentEnvironment{subtask}{o}{
        \tl_if_in:nnT {#1} {=} {
            \keys_set:nn {ptxcd/subtask} {#1}
        }
        \bool_if:NTF \l_ptxcd_ex_subtask_fallback_bool {
            \@subtask{\IfNoValueF{#1}{#1}}
        }{
            \@subtask{\l_ptxcd_ex_title_tl}
        }

        \tl_clear_new:N \l__ptxcd_task_properties_collector_tl
        \tl_set_eq:NN \l__ptxcd_task_properties_collector_tl \g__ptxcd_task_properties_collector_tl
        \rubos_prop_nested_set:Nxx \l__ptxcd_task_properties_collector_tl {\the\value{task}, subtasks, \the\value{subtask}} {
            title={\tl_to_str:N \l_ptxcd_ex_title_tl},
            credit={\tl_to_str:N \l_ptxcd_ex_subtask_credit_tl},
            points={\fp_use:N \l_ptxcd_ex_subtask_points_fp},
            thesubtask={\exp_args:Ne\tl_to_str:n{\thesubtask}},
            subtaskformat={\exp_args:Ne\tl_to_str:n{\subtaskformat}},
        }
        \tl_gset_eq:NN \g__ptxcd_task_properties_collector_tl \l__ptxcd_task_properties_collector_tl
    }{}
    \newcommand*{\ptxcd@LoadTaskProperties}[1]{
        \tl_gset:Nn \g__ptxcd_task_properties_loaded_tl {#1}
    }

    \bool_if:NT \g__ptxcd_points_bool {
        \BeforeClosingMainAux{
            \iow_now:Nx \@auxout{
                \exp_not:N \ptxcd@LoadTaskProperties{\g__ptxcd_task_properties_collector_tl}
            }
        }
    }

    % Modify GetPoints Command to work with makros
    \DeclareDocumentCommand{\getPoints}{m}{
        % \exp_args:NNx \prop_get:NnNTF \g__ptxcd_loaded_points_prop {#1} \l_tmpa_tl
        \rubos_prop_nested_get:NxNTF \g__ptxcd_task_properties_loaded_tl {#1,points} \l_tmpa_tl
        {\l_tmpa_tl}
        {\nfss@text{\reset@font\bfseries??}}
    }

    \DeclareDocumentCommand{\getSubPoints}{m m}{
        \rubos_prop_nested_get:NxNTF \g__ptxcd_task_properties_loaded_tl {#1,subtasks,#2,points} \l_tmpa_tl
        {\l_tmpa_tl}
        {\nfss@text{\reset@font\bfseries??}}
    }

    \newcommand{\getTaskTitle}[1]{
        \exp_args:Nnx \__rubos_nested_contains:nnTF {\g__ptxcd_task_properties_loaded_tl} {#1,title}
        {
            \exp_args:NNx \rubos_prop_nested_get:nn {\g__ptxcd_task_properties_loaded_tl} {#1,title}
        }
        {\nfss@text{\reset@font\bfseries??}}
    }
    \newcommand{\getSubTaskTitle}[2]{
        \exp_args:Nnx \__rubos_nested_contains:nnTF {\g__ptxcd_task_properties_loaded_tl} {#1,subtasks,#2,title}
        {
            \exp_args:NNx \rubos_prop_nested_get:nn {\g__ptxcd_task_properties_loaded_tl} {#1,subtasks,#2,title}
        }
        {\nfss@text{\reset@font\bfseries??}}
    }

    % Get Property of a Task, or prints ?? if not present
    % [#1]: Optional task number (can be obtained by \the\value{task})
    % #2: Property Name (key)
    \DeclareDocumentCommand{\getTaskProperty}{O{\the\value{task}} m}{
        \rubos_prop_nested_get:NxNTF \g__ptxcd_task_properties_loaded_tl {#1,#2} \l_ptxcd_temp_task_prop_tl
        {
            \l_ptxcd_temp_task_prop_tl
        }
        {\nfss@text{\reset@font\bfseries??}}
    }

    % Get Property of a Subtask, or prints ?? if not present
    % [#1]: Optional task number (can be obtained by \the\value{task})
    % [#2]: Optional subtask number (can be obtained by \the\value{subtask})
    % #3: Property Name (key)
    \DeclareDocumentCommand{\getSubTaskProperty}{O{\the\value{task}} O{\the\value{subtask}} m}{
        \rubos_prop_nested_get:NxNTF \g__ptxcd_task_properties_loaded_tl {#1,subtasks,#2,#3} \l_ptxcd_temp_subtask_prop_tl
        {
            \l_ptxcd_temp_subtask_prop_tl
        }
        {
            \nfss@text{\reset@font\bfseries??}
        }
    }

    % Logik zum rausfinden ob es einen subtask gibt
    \newcommand{\IfSubtasksTF}[3][\the\value{task}]{
        \exp_args:Nnx \__rubos_nested_contains:nnTF {\g__ptxcd_task_properties_loaded_tl} {#1,subtasks} {#2} {#3}
    }


    % \DeclareDocumentCommand{\mapTasks}{sO{1}m}{
    %   % \cs_gset_nopar:Nn \__ptxcd_map_points_helper:nn {#3}
    %   \prop_if_empty:NTF \g__ptxcd_loaded_points_prop {
    %     \msg_warning:nn {tudaexercise} {empty-point-mapping}
    %     %  \__ptxcd_map_points_helper:nn {?task?} {?points?}
    %   }{
    %     \int_gset:Nn \g_ptxcd_tmp_int {\value{task}}
    %     \setcounter{task}{#2}
    %     \bool_gset_true:N \g_tmpa_bool
    %     \bool_while_do:Nn \g_tmpa_bool
    %     {
    %       \exp_args:NNx \prop_get:NnNTF \g__ptxcd_loaded_points_prop {\thetask} \l_tmpa_tl
    %       {
    %         \bool_if:nT {#1 || !\fp_compare_p:n {\l_tmpa_tl = 0}}
    %         {
    %           % \group_begin:
    %           #3
    %           % \group_end:
    %         }
    %       }
    %       {\bool_gset_false:N \g_tmpa_bool}
    %       \stepcounter{task}
    %     }
    %     \setcounter{task}{\int_use:N \g_ptxcd_tmp_int}
    %   }
    % }

    \prg_new_conditional:Nnn \__rubos_if_points_loaded: { T, F ,TF } {
        \tl_if_empty:NTF \g__ptxcd_task_properties_loaded_tl
        {\prg_return_false:}
        {\prg_return_true:}
    }

    \cs_set_eq:NN\IfPointsLoadedT \__rubos_if_points_loaded:T
    \cs_set_eq:NN\IfPointsLoadedF \__rubos_if_points_loaded:F
    \cs_set_eq:NN\IfPointsLoadedTF \__rubos_if_points_loaded:TF

    % Star currently useless
    \DeclareDocumentCommand{\mapTasks}{s O{1} O{-1} m}{
        \prop_clear_new:N \l_temp_task_mapping_prop
        \exp_args:NNf \prop_set_from_keyval:Nn \l_temp_task_mapping_prop {
            \g__ptxcd_task_properties_loaded_tl
        }
        \int_zero_new:N \l_ptxcd_orig_task_int
        \int_set:Nn \l_ptxcd_orig_task_int {\value{task}}
        \setcounter{task}{#2}
        \prop_map_inline:Nn \l_temp_task_mapping_prop {
            \bool_if:nT {\int_compare_p:n {##1 >= #2} && (\int_compare_p:n {#3 = -1} || \int_compare_p:n {##1 <= #3})}{
                \setcounter{task}{##1}
                #4
            }
        }
        \setcounter{task}{\int_use:N \l_ptxcd_orig_task_int}
    }

    % Subtasks mapping
    \DeclareDocumentCommand{\mapSubtasks}{s O{1} m}{
        \rubos_prop_nested_get:NxNTF \g__ptxcd_task_properties_loaded_tl {\the\value{task},subtasks} \l_temp_subtask_points_tl
        {
            \prop_clear_new:N \l_temp_subtask_mapping_prop
            \exp_args:NNf \prop_set_from_keyval:Nn \l_temp_subtask_mapping_prop {
                \l_temp_subtask_points_tl
            }
            \int_zero_new:N \l_ptxcd_orig_subtask_int
            \int_set:Nn \l_ptxcd_orig_subtask_int {\value{subtask}}
            \setcounter{subtask}{#2}
            \prop_map_inline:Nn \l_temp_subtask_mapping_prop {
                \int_compare:nT {##1 >= #2}{
                    \setcounter{subtask}{##1}
                    #3
                }
            }
            \setcounter{subtask}{\int_use:N \l_ptxcd_orig_subtask_int}
        }
        {}
    }
}{}

% #1: Token List which is a nested Property List (like: {3={a)=3,b)=2,},4={a)=5,b)=3,c)=8}})
% #2: Comma List (List of the keys to get the desired value)
% returns: Tokenlist
\cs_new:Npn \rubos_prop_nested_get:nn #1#2 {
    \tl_clear_new:N \l_rubos_nestedcurr_tl
    \tl_set:Nn \l_rubos_nestedcurr_tl {#1}
    \prop_clear_new:N \l_rubos_nestedcurr_prop
    \clist_map_inline:nn {#2}{
        % Check if Current Tokenlist is a Property List
        \__rubos_is_prop_list:nTF {\tl_use:N \l_rubos_nestedcurr_tl} {
            % Current List is a Property List
            % Parse Property List
            \exp_args:NNf \prop_set_from_keyval:Nn \l_rubos_nestedcurr_prop {
                \l_rubos_nestedcurr_tl
            }
            % Make sure key is present
            \prop_if_in:NnTF \l_rubos_nestedcurr_prop {##1} {
                % Key is present
                \prop_get:NnN \l_rubos_nestedcurr_prop {##1} \l_rubos_nestedcurr_tl
            } {
                % Key is not present
                \ClassError{rubos_tuda_template}{Subproperty~##1~does~not~exist~the~nested~property~list!}{Subproperty~##1~does~not~exist~the~nested~property~list!}
            }
        }{
            % Current List is no Property List
            \ClassError{rubos_tuda_template}{Subproperty~##1~could~not~be~found~because~toplist~is~no~property~list!}{toplist~is~no~property~list}
        }
    }
    % Put result in Output stream
    \tl_use:N \l_rubos_nestedcurr_tl
}

\cs_set_eq:NN\nestedget \rubos_prop_nested_get:nn

\prg_new_protected_conditional:Npnn \rubos_prop_nested_get:NnN #1#2#3 { T, F, TF }{
    \tl_clear_new:N \l_rubos_nestedcurr_tl
    \tl_set_eq:NN \l_rubos_nestedcurr_tl #1
    \bool_set_true:N \l_rubos_nestedcontains_bool
    \prop_clear_new:N \l_rubos_nestedcurr_prop
    \clist_map_inline:nn {#2}{
        \bool_if:NT \l_rubos_nestedcontains_bool {

            % Check if Current Tokenlist is a Property List
            \exp_args:Nf \__rubos_is_prop_list:nTF {\l_rubos_nestedcurr_tl} {
                % Current List is a Property List
                % Parse Property List
                \exp_args:NNf \prop_set_from_keyval:Nn \l_rubos_nestedcurr_prop {
                    \l_rubos_nestedcurr_tl
                }
                % Make sure key is present
                \prop_if_in:NnTF \l_rubos_nestedcurr_prop {##1} {
                    % Key is present
                    \prop_get:NnN \l_rubos_nestedcurr_prop {##1} \l_rubos_nestedcurr_tl
                } {
                    % Key is not present
                    \bool_set_false:N \l_rubos_nestedcontains_bool
                }
            }{
                % Current List is no Property List
                \bool_set_false:N \l_rubos_nestedcontains_bool
            }
        }
    }
    \bool_if:NTF \l_rubos_nestedcontains_bool {
        % Copy Result to output list
        \tl_set_eq:NN #3 \l_rubos_nestedcurr_tl
        \prg_return_true:
    }{
        \prg_return_false:
    }
}

\prg_generate_conditional_variant:Nnn \rubos_prop_nested_get:NnN { NV , Nv , No, Nx , c , cV , cv , co, cx } { T, F, TF }

% #1: Token List which is a nested Property List (will throw class error if token List is faulty!!)
% #2: Comma List (List of the keys to get the desired value)
% #3: The Value to set (token List)
% returns: Tokenlist
\cs_new:Npn \rubos_prop_nested_set:Nnn #1#2#3 {
    \tl_clear_new:N \l_rubos_nestedcurr_tl
    \tl_set_eq:NN \l_rubos_nestedcurr_tl {#1}
    \clist_clear_new:N \l_rubos_nestedkeys_remaining_clist
    \clist_set:Nn \l_rubos_nestedkeys_remaining_clist {#2}
    \clist_clear_new:N \l_rubos_nestedkeys_done_clist
    \str_clear_new:N \l_rubos_nestedkeys_current_key_tl
    \seq_clear_new:N \l_rubos_nestedstack_seq
    \prop_clear_new:N \l_rubos_nestedcurr_prop
    \bool_set_true:N \l_rubos_nestediterate_bool
    % Fill Stack and find out insertion point
    \bool_while_do:Nn \l_rubos_nestediterate_bool {
        % Keys remain
        \clist_pop:NNTF \l_rubos_nestedkeys_remaining_clist \l_rubos_nestedkeys_current_key_tl {
            \exp_args:NNe \clist_push:Nn \l_rubos_nestedkeys_done_clist {\l_rubos_nestedkeys_current_key_tl}
            % Check if Current Tokenlist is a Property List
            \__rubos_is_prop_list:nTF {\l_rubos_nestedcurr_tl} {
                % Current List is a Property List
                % Parse Property List
                \exp_args:NNf \prop_set_from_keyval:Nn \l_rubos_nestedcurr_prop {
                    \l_rubos_nestedcurr_tl
                }
                \exp_args:NNf \seq_put_left:Nn \l_rubos_nestedstack_seq {\l_rubos_nestedcurr_tl}
                % Test if key is present
                \exp_args:NNf \prop_get:NnNF \l_rubos_nestedcurr_prop {\l_rubos_nestedkeys_current_key_tl} \l_rubos_nestedcurr_tl {
                    % Key is not Present
                    \bool_set_false:N \l_rubos_nestediterate_bool
                }
            }{
                % Current List is no Property List
                \bool_set_false:N \l_rubos_nestediterate_bool
                \ClassError{rubos_tuda_template}{List~that~should~contain~Property~\tl_use:N \l_rubos_nestedkeys_current_key_tl~is~no~property~list!}{Token~List~is~no~property~list}
            }
        } {
            % no keys remain
            \bool_set_false:N \l_rubos_nestediterate_bool
        }
    }

    % Create nested Property List to insert based on insertion point
    \tl_clear_new:N \l_rubos_new_nestedprop_tl
    \tl_set:Nn \l_rubos_new_nestedprop_tl {#3}
    \clist_reverse:N \l_rubos_nestedkeys_remaining_clist
    \clist_map_inline:Nn \l_rubos_nestedkeys_remaining_clist {
        \prop_clear:N \l_rubos_nestedcurr_prop
        \prop_put:Noo \l_rubos_nestedcurr_prop {##1} {\l_rubos_new_nestedprop_tl}
        \tl_clear:N \l_rubos_new_nestedprop_tl
        \prop_map_inline:Nn \l_rubos_nestedcurr_prop {
            \tl_put_right:Nn \l_rubos_new_nestedprop_tl {####1={####2},}
        }
    }

    % Insert at insertion point using the stack
    \clist_map_inline:Nn \l_rubos_nestedkeys_done_clist {
        % ##1,
        % Parse Next Prop List from Stack
        \prop_clear:N \l_rubos_nestedcurr_prop
        \seq_pop_left:NN \l_rubos_nestedstack_seq \l_rubos_nestedcurr_tl
        \exp_args:NNo \prop_set_from_keyval:Nn \l_rubos_nestedcurr_prop {
            \l_rubos_nestedcurr_tl
        }
        % \tl_set:Nx \l_rubos_nestedstack_tl {\tl_tail:N \l_rubos_nestedstack_tl}
        \prop_put:Noo \l_rubos_nestedcurr_prop {##1} {\l_rubos_new_nestedprop_tl}

        \tl_clear:N \l_rubos_new_nestedprop_tl
        \prop_map_inline:Nn \l_rubos_nestedcurr_prop {
            \tl_put_right:Nn \l_rubos_new_nestedprop_tl {####1={####2},}
        }
    }

    % % Copy result to Output List
    \tl_set_eq:NN #1 \l_rubos_new_nestedprop_tl
}

\cs_generate_variant:Nn \rubos_prop_nested_set:Nnn { Nxx, Nxn, Noo, Nxo }

\cs_set_eq:NN\nestedset \rubos_prop_nested_set:nn

\prg_new_conditional:Npnn \__rubos_is_prop_list:n #1 { p, T, F, TF } {
    \bool_if:nT {\tl_if_empty_p:n {#1} || \tl_if_blank_p:n {#1}} {\prg_return_true:}
    \bool_set_true:N \l_rubos_is_prop_bool
    \exp_args:Nf \clist_map_inline:nn {#1} {
        \bool_if:NT \l_rubos_is_prop_bool {
            % ##1
            \bool_if:nF {\tl_if_empty_p:n {#1} || \tl_if_blank_p:n {#1}} {
                % Must contain =
                \tl_if_in:nnF {##1} {=} {\bool_set_false:N \l_rubos_is_prop_bool}
                % Must have at least length 3
                \int_compare:nF {\tl_count:n {##1} > 2} {\bool_set_false:N \l_rubos_is_prop_bool}
                \regex_match:nnF {.+=.+} {##1} {\bool_set_false:N \l_rubos_is_prop_bool}
                % Might refine Logic later
                % \int_zero_new:N \l_tmp_regex_match_count_int
                % \regex_count:nnN {=} {##1} \l_tmp_regex_match_count_int
                % \int_compare:nF {\l_tmp_regex_match_count_int = 1} {\int_use:N \l_tmp_regex_match_count_int \bool_set_false:N \l_rubos_is_prop_bool}
            }
        }
    }
    \bool_if:NTF \l_rubos_is_prop_bool {
        \prg_return_true:
    } {
        \prg_return_false:
    }
}

% #1: Token List which is a nested Property List (like: {3={a)=3,b)=2,},4={a)=5,b)=3,c)=8}})
% #2: Comma List (List of the keys to get the desired value)
\prg_new_conditional:Npnn \__rubos_nested_contains:nn #1#2 { p, T, F, TF } {
    \tl_clear_new:N \l_rubos_nestedcurr_tl
    \tl_set:Nf \l_rubos_nestedcurr_tl {#1}
    \prop_clear_new:N \l_rubos_nestedcurr_prop
    % Since you can't use the return statement inside a map function...
    \bool_set_true:N \l_rubos_nestedcontains_bool
    \clist_map_inline:nn {#2}{
        \bool_if:NT \l_rubos_nestedcontains_bool {
            % Check if Current Tokenlist is a Property List
            \tl_if_in:NnTF \l_rubos_nestedcurr_tl {=} {
                % Current List is a Property List
                % Parse Property List
                \exp_args:NNf \prop_set_from_keyval:Nn \l_rubos_nestedcurr_prop {
                    \l_rubos_nestedcurr_tl
                }
                % Make sure key is present
                \prop_if_in:NnTF \l_rubos_nestedcurr_prop {##1} {
                    % Key is present
                    \prop_get:NnN \l_rubos_nestedcurr_prop {##1} \l_rubos_nestedcurr_tl
                } {
                    % Key is not present
                    \bool_set_false:N \l_rubos_nestedcontains_bool
                }
            }{
                % Current List is no Property List
                \bool_set_false:N \l_rubos_nestedcontains_bool
            }
        }
    }
    % Wanted Key is contained
    \bool_if:NTF \l_rubos_nestedcontains_bool {
        \prg_return_true:
    } {
        \prg_return_false:
    }
}

\prg_generate_conditional_variant:Nnn \rubos_prop_nested_get:nn { nx , ne } { p, T , F , TF }

\cs_set_eq:NN\IfNestedContainsT \__rubos_nested_contains:nnT
\cs_set_eq:NN\IfNestedContainsF \__rubos_nested_contains:nnF
\cs_set_eq:NN\IfNestedContainsTF \__rubos_nested_contains:nnTF

\cs_new:Npn \rubos_print_nested_tl:n #1 {
    % \tl_set:Nf \l_tmpa_tl {#1}
    \{
    \exp_args:Nf \tl_to_str:n {#1}
    \}
}

\cs_set_eq:NN \printNested \rubos_print_nested_tl:n

% --Document Settings-- %

% Sheet number
\newcommand*{\getSheetnumber}{
    \IfTudaciVersionAtLeastTF{3.0}{
        \g_ptxcd_ex_sheetnum_tl
    }{
        \g_TUDa_ex_sheetnum_tl
    }}
\newcommand*{\printSheetNumber}{\tl_if_empty:NF \g_ptxcd_ex_sheetnum_tl {\sffamily\textbf{Übungsblatt\space{}Nummer:}\space\padzeroes{\getSheetnumber}}}

% Group Number
\DeclareDocumentProperty{groupNumber}[][\textsf{\textbf{Übungsgruppe~Nummer:~}*}]
\cs_set_eq:NN \groupnumber \groupNumber % Legacy Support

% Group Leader
\DeclareDocumentProperty{groupLeader}[][\textsf{\textbf{Übungsgruppenleiter:~}*}]
\cs_set_eq:NN \groupleader \groupLeader % Legacy Support

% Dozent
\DeclareDocumentProperty{dozent}[][\textsf{\textbf{Dozent:~}*}]


% Topic
\DeclareDocumentProperty{topic}[][\textsf{\textbf{Themen:~}*}]

% slides
\DeclareDocumentProperty{slides}[][\sffamily\textbf{\sffamily\textbf{Relevante\space{}Foliensätze:}\hfill *}]

% Due Date
\DeclareDocumentProperty{dueDate}[][\sffamily\textbf{Abgabe~der~Hausübung:}\hfill *]

% Total Points
\newcommand*{\printTotalPoints}{\textbf{\textsf{Maximal\space{}erreichbare\space{}Punkte:}}\hfill\getPointsTotal{}\space{}\fp_compare:nTF {\getPointsTotal{}=1}\PointName\PointsName}

% Semester
\DeclareDocumentProperty{semester}[][\textsf{\textbf{Semester:~}*}]

% Fachbereich
\DeclareDocumentProperty{fachbereich}[][\textsf{\textbf{Fachbereich:~}*}]

% Short Title
\newcommand*{\getShortTitle}{
    \IfTudaciVersionAtLeastTF{3.0}{
        \g_ptxcd_shorttitle_tl
    }{
        \g_TUDa_shorttitle_tl
    }
}

% Author
\tl_gclear_new:N \printAuthor
\renewcommand*{\author}[1]{
    \seq_gset_split:Nnn \g_ptxcd_author_seq {\and} {#1}
    \seq_if_empty:NF \g_ptxcd_author_seq {\tl_gset:Nn \printAuthor {\textbf{\textsf{\int_compare:nTF{\seq_count:N \g_ptxcd_author_seq > 1}{Authoren}{Author}:~}}\seq_use:Nnnn \g_ptxcd_author_seq {~\authorandname{}~} {,~} {~\authorandname{}~}}}
}

% Contributors
\seq_new:N \g_ptxcd_contributor_seq
\tl_gclear_new:N \printContributor
\newcommand*\contributor[1]{
    \seq_gset_split:Nnn \g_ptxcd_contributor_seq {\and} {#1}
    \seq_if_empty:NF \g_ptxcd_contributor_seq {\tl_gset:Nn \printContributor {\textbf{\textsf{Helfer:~}}\seq_use:Nnnn \g_ptxcd_contributor_seq {~\authorandname{}~} {,~} {~\authorandname{}~}}}
}

% Submittors
\seq_new:N \g_ptxcd_submittors_seq
% \tl_gclear_new:N \printSubmittors
% \ifcsname c@submittor\endcsname\else
%   \newcounter{submittor}
% \fi
% \setcounter{submittor}{0}
\newcommand*{\addSubmittor}[2]{
    \bool_if:nF \g_is_submission_bool {
        \ClassError{rubos_tuda_template}{Dieser~Befehl~Benötigt~den~submission~Modus}{Schalte~den~submission~Modus~ein}
    }
    \str_if_eq:nnT {#1} {} {
        \ClassError{rubos_tuda_template}{Name~darf~nicht~leer~sein!}{Gib~einen~gültigen~Namen~ein}
    }
    \bool_if:NT \g_rubos_require_id_bool{
        \str_if_eq:nnT {#2} {} {
            \ClassError{rubos_tuda_template}{Matrikelnummer~darf~nicht~leer~sein!}{Gib~eine~gültige~Matrikelnummer~ein}
        }
    }

    \seq_gput_right:Nn \g_ptxcd_submittors_seq {#1}
    \tl_gclear_new:c {ptxcd_submittors_#1_matrikelnummer_tl}
    \tl_gset:cn {ptxcd_submittors_#1_matrikelnummer_tl} {#2}
    % \seq_if_empty:NF \g_ptxcd_submittors_seq {\tl_gset:Nn \printContributor {\textbf{\textsf{Helfer:~}}\seq_use:Nnnn \g_ptxcd_submittors_seq {~\authorandname{}~} {,~} {~\authorandname{}~}}}
}

\newcommand*{\getMatrikelnummer}[1]{
    \use:c {ptxcd_submittors_#1_matrikelnummer_tl}
}

\DeclareExpandableDocumentCommand{\printSubmittor}{s m}{
    #2
    \bool_if:nT { !#1 && !\str_if_eq_p:ee {\getMatrikelnummer{#2}} {}} {
        \space{}(Mat.:~\getMatrikelnummer{#2})
    }
}

\DeclareExpandableDocumentCommand{\printSubmittors}{s m}{
    \textsf{\textbf{Abgabe}}
    \seq_if_empty:NF \g_ptxcd_submittors_seq {
        \textsf{\textbf{\space{}von:}}
        \\
        \gdef\ptxcd_nextsep_submittors{}
        \seq_map_inline:Nn \g_ptxcd_submittors_seq {
            \ptxcd_nextsep_submittors{}
            \bool_if:nTF {#1} {
                \printSubmittor*{##1}
            } {
                \printSubmittor{##1}
            }
            \gdef\ptxcd_nextsep_submittors{,\\}
        }
    }
}

% \newcommand*{\printContributor}{
%   \seq_if_empty:NF \g_ptxcd_contributor_seq {\textbf{\textsf{Helfer:~}}\seq_use:Nnnn \g_ptxcd_contributor_seq {~\authorandname{}~} {,~} {~\authorandname{}~}}
% }

% Date
\tl_gclear_new:N \printDate
\renewcommand*{\date}[1]{
    \tl_gset:Nn \@date {#1}
    \tl_if_empty:NF \@date {\tl_gset:Nn \printDate {\textsf{\textbf{\datename{}:~}}\@date}}
}
% \newcommand*{\printDate}{
%   \tl_if_empty:NF \@date {\textbf{\textsf{Datum:~}}\@date}
% }

\clist_new:N \g_rubos_ex_term_order_clist
\clist_gset:Nn \g_rubos_ex_term_order_clist {printAuthor,printSemester,printContributor,printVersion,quad,quad,printDate,printFachbereich}
\newcommand*{\termOrder}[1]{\tl_gset:Nn \g_rubos_ex_term_order_clist {#1}}

\tl_gclear_new:N \g_ptxcd_ex_term_style_tl
\newcommand*{\termStyle}[1]{\tl_gset:Nn \g_ptxcd_ex_term_style_tl {#1}}
\termStyle{left-right}
\seq_gclear_new:N \g_ptxcd_term_left_seq
\seq_gclear_new:N \g_ptxcd_term_right_seq
\newcommand{\termLeft}[1]{
    \clist_gclear_new:N \g_ptxcd_temp_clist
    \tl_gset:Nn \g_ptxcd_temp_clist {#1}
    \clist_map_inline:Nn \g_ptxcd_temp_clist {
        \tl_if_empty:cF {##1} {
            \seq_put_right:Nn \g_ptxcd_term_left_seq {\use:c {##1}}
        }
    }
}
\newcommand{\termRight}[1]{
    \clist_gclear_new:N \g_ptxcd_temp_clist
    \tl_gset:Nn \g_ptxcd_temp_clist {#1}
    \clist_map_inline:Nn \g_ptxcd_temp_clist {
        \tl_if_empty:cF {##1} {
            \seq_put_right:Nn \g_ptxcd_term_right_seq {\use:c {##1}}
        }
    }
}


% --Style Stuff--%

% Section Fonts
\setkomafont{section}{\large\bfseries\sffamily}
\setkomafont{subsection}{\normalsize\bfseries\sffamily}
\setkomafont{subsubsection}{\normalsize\bfseries\sffamily}

% Center Captions
\captionsetup[figure]{justification=centering}
\captionsetup[subfigure]{justification=centering}
\captionsetup[table]{justification=centering}

% Remove unwanted space from tables
\aboverulesep = 0mm \belowrulesep = 0mm

% Description-list styling.
\SetLabelAlign{parright}{\parbox[t]{\labelwidth}{\raggedleft#1}}
\setlist[description]{style = multiline, leftmargin = 4cm, align = parright,font=\mdseries}

\renewcommand*{\thetask}{%
    \texorpdfstring{}{H}%
    \arabic{task}%
}

\def\rubos@boxarc{\prop_item:Nn \g_rubos_document_opts_prop {boxarc}} % Used for Code Blocks, Info boxes, etc.

\renewcommand*{\taskformat}{H\thetask{}} % Taskprefix

% Point Formating
\renewcommand*{\creditformat}[1]{\hfill#1}
\renewcommand*{\subtaskformat}{\thetask{}\space\thesubtask\enskip}

% Define Glossary style
\ifthenelse{\isundefined{\printindex}}{}{
    \makeindex[
        columns=3,
        title=Stichwortverzeichnis,
        intoc,
        options=-s~mystyle % Requires mystyle.ist, see repo
    ]
    %Fix indent for glossary
    \def\@idxitem{\par\hangindent 0pt}
}

% Advanced Styling
\IfDarkModeT{
    \IfFileExists{tuda_logo_inverted.pdf} {
        \tl_gset:Nn \g_ptxcd_logofile_tl {tuda_logo_inverted.pdf}
    } {}
}

\IfTudaciVersionBetweenTF{2.10}{2.11}{
    \cs_new:Nn \ptxcd_define_captionFallback:Nn {
        \providecommand*#1{
            \msg_warning:nnxxx{tudapub} {unknown-language}
            {\languagename} {\exp_not:N #1} {#2}
            \def#1{#2}
        }
    }
}{}

\IfTudaciVersionBetweenTF{3.0}{3.19}{
    \cs_new:Nn \ptxcd_declare_caption:Nnnn {
        \ptxcd_define_captionFallback:Nn #1 {#2}
        \defcaptionname{ngerman, german}{#1}{#2}
        \defcaptionname{english, USenglish, american}{#1}{#3}
        \defcaptionname{UKenglish, british}{#1}{#4}
    }

    \cs_new:Nn \ptxcd_declare_caption:Nnn {
        \ptxcd_declare_caption:Nnnn #1 {#2} {#3} {#3}
    }

    \ptxcd_declare_caption:Nnn \authorandname {und} {and}
}{}

\newcommand*{\@contributor}{
    \begingroup
    \hyphenpenalty=100000
    \seq_use:Nnnn \g_ptxcd_contributor_seq {~\authorandname{}~} {,~} {~\&~}
    \endgroup
}
\renewcommand*{\@author}{
    \begingroup
    \hyphenpenalty=100000
    \IfTudaciVersionAtLeastTF{3.0}{
        \seq_use:Nnnn \g_ptxcd_author_seq {~\authorandname{}~} {,~} {~\&~}
    }{
        \seq_use:Nnnn \g_TUDa_author_seq {~\authorandname{}~} {,~} {~\&~}
    }
    \endgroup
}

\IfTudaciVersionAtLeastTF{3.0}{
    \renewcommand*{\@maketitle}{%
        % \maketerm{}% Might Move Term Creation here soon
        \global\@topnum=\z@
        \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
        \vspace*{-\dim_eval:n {
                \headheight
                -\c_ptxcd_largerule_dim -\c_ptxcd_rulesep_dim
                +\headsep
                +\ht\strutbox
                +\p@
            }}
        \par
        \nointerlineskip
        \begingroup
        \setlength{\fboxsep}{\z@}
        \bool_if:NT \g_ptxcd_colorback_bool {\colorbox{accentcolor}}{\parbox[t]{\linewidth}{
                \rule{0pt}{\bool_if:NTF \g_ptxcd_smalltitle_bool {.25} {.5}\c_ptxcd_logoheight_dim}
                \par\nointerlineskip
                \raisebox{-\height}{%
                    \begin{minipage}[t]{\dimexpr\linewidth-2.2\c_ptxcd_logoheight_dim-1ex}
                        \bool_if:NT \g_ptxcd_colorback_bool  {\begin{addmargin}{3mm}}
                                \raggedright
                                \bool_if:NT \g_ptxcd_colorback_bool {\color{textonaccentcolor}}
                                \tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
                                \leavevmode\usekomafont{title}%
                                {\usekomafont{title}\bool_if:NTF \g_ptxcd_smalltitle_bool {\LARGE} {\huge} {\@title\par}}%
                                \vskip 1em
                                \bool_if:NF \g_ptxcd_ex_compatibility_bool
                                {
                                    {\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
                                    \gdef\@subtitle{}
                                    \vskip .5em
                                }
                                % Standart Author Position
                                % {
                                %   \xdef\@author {\@author}
                                %   \ifx\@author\@empty\else\usekomafont{author}\@author\par\fi
                                % }
                                \vskip .5em
                                \bool_if:NTF \g_ptxcd_colorback_bool {\end{addmargin}} {\par}
                    \end{minipage}}
                \tl_if_empty:NF \g_ptxcd_logofile_tl {
                    \hfill\raisebox{\dim_eval:n {
                            \bool_if:NTF \g_ptxcd_colorback_bool
                            {-\height}
                            {-.9\c_ptxcd_logoheight_dim}
                        }}
                    [0pt]
                    [\dim_eval:n {
                            \bool_if:NTF \g_ptxcd_smalltitle_bool
                            {\bool_if:NTF \g_ptxcd_colorback_bool {1.15}{1}}
                            {\bool_if:NTF \g_ptxcd_colorback_bool {1.5}{1.3}
                            }\c_ptxcd_logoheight_dim}]
                    {\makebox[2.2\c_ptxcd_logoheight_dim][l]{\includegraphics[height=\c_ptxcd_logoheight_dim]{\g_ptxcd_logofile_tl}}}
                }
                \par\medskip
            }}
        \par
        \nointerlineskip
        \rule{\linewidth}{\g_ptxcd_titlerule_dim}
        % subtitle fields if not compat
        \exp_args:Nf \tl_if_empty:nF {\seq_use:Nnnn \g_ptxcd_author_seq {~\authorandname{}~} {,~} {~\&~}\seq_use:Nnnn \g_ptxcd_contributor_seq {~\authorandname{}~} {,~} {~\authorandname{}~}\g_ptxcd_ex_sheetnum_tl\@date\g_ptxcd_ex_term_tl\use:c {@subsubtitle}\@subtitle}{
            \par\nointerlineskip
            \bool_if:NT \g_ptxcd_colorback_bool {\colorbox{accentcolor}}{
                \parbox{\linewidth}{
                    \begin{minipage}{\linewidth}
                        \bool_if:NT \g_ptxcd_colorback_bool {
                            \color{textonaccentcolor}
                            \begin{addmargin}{3mm}
                                }
                                \null\par
                                % Term
                                \bool_if:NTF \g_manual_term_bool{
                                    \g_ptxcd_ex_term_tl
                                }
                                {
                                    \def\ptxcd_nextsep{}
                                    \bool_gset_true:N \g_tmpa_left_bool
                                    \clist_map_inline:Nn \g_rubos_ex_term_order_clist {
                                        % Process different term Styles
                                        \str_case_e:nnF {\g_ptxcd_ex_term_style_tl} {
                                            {left} {
                                                \tl_if_empty:cF {##1} {
                                                    \seq_put_right:cn {\bool_if:nTF \g_tmpa_left_bool {g_ptxcd_term_left_seq} {g_ptxcd_term_right_seq}} {\use:c {##1}}
                                                }
                                            }
                                            {center} {
                                                \tl_if_empty:cF {##1} {
                                                    \seq_put_right:cn {\bool_if:nTF \g_tmpa_left_bool {g_ptxcd_term_left_seq} {g_ptxcd_term_right_seq}} {\use:c {##1}}
                                                }
                                            }
                                            {left-right} {
                                                \tl_if_empty:cF {##1} {
                                                    \seq_put_right:cn {\bool_if:nTF \g_tmpa_left_bool {g_ptxcd_term_left_seq} {g_ptxcd_term_right_seq}} {\use:c {##1}}\bool_set:Nn \g_tmpa_left_bool {!\g_tmpa_left_bool}
                                                }
                                            }
                                            {left-right-manual} {
                                                % Do Nothing lol
                                            }
                                        }
                                        {
                                            \ClassError{rubos_tuda_template}{Unknown~Term~style~Option: \use:c {\g_ptxcd_ex_term_style_tl}}{Available~options~are:~left,~center,~left-right~(default)}
                                        }
                                    }
                                    % Left Side
                                    \begin{minipage}[t]{\seq_if_empty:NF {\g_ptxcd_term_right_seq}{.6}\linewidth}
                                        \str_if_eq:eeT{\g_ptxcd_ex_term_style_tl} {center} {\centering}
                                        \seq_use:Nnnn \g_ptxcd_term_left_seq {\mbox{}\par} {\mbox{}\par} {\mbox{}\par}
                                        \gdef\ptxcd_nextsep{\par}
                                    \end{minipage}
                                    \seq_if_empty:NF {\g_ptxcd_term_right_seq}{
                                        \begin{minipage}[t]{.4\linewidth}
                                            \raggedleft
                                            \begin{flushright}
                                                \seq_use:Nnnn \g_ptxcd_term_right_seq {\mbox{}\par} {\mbox{}\par} {\mbox{}\par}
                                            \end{flushright}
                                            \gdef\ptxcd_nextsep{\par}
                                        \end{minipage}
                                    }
                                    % \vspace{-\abovedisplayskip}
                                    \bool_if:nT { !\seq_if_empty_p:N \g_ptxcd_term_left_seq || !\seq_if_empty_p:N \g_ptxcd_term_right_seq } {
                                        \vspace*{\lineskip}
                                        \par
                                    }
                                    \tl_if_empty:NF \g_ptxcd_ex_term_tl {\g_ptxcd_ex_term_tl}
                                    % \clist_map_inline:nn {@subtitle, @subsubtitle, g_ptxcd_ex_term_tl} {
                                    %   \tl_if_empty:cF {##1} {\ptxcd_nextsep\use:c {##1}\def\ptxcd_nextsep{\\}}
                                    % }
                                    % \tl_if_empty:NF \g_ptxcd_ex_sheetnum_tl {\ptxcd_nextsep\sheetname\sheetsep\g_ptxcd_ex_sheetnum_tl}
                                }

                                \bool_if:NT \g_ptxcd_colorback_bool {\end{addmargin}}
                    \end{minipage}
                    \vspace*{\dp\strutbox}
                }}\par\nointerlineskip
            \rule{\linewidth}{\g_ptxcd_titlerule_dim}
        }
        \par
        \bool_if:NT  \g_ptxcd_headontitle_bool {
            \if@twoside
                \box_use:N \g_ptxcd_ex_headline_odd_box
            \else
                \box_use:N \g_ptxcd_ex_headline_oneside_box
            \fi
            \par
            \rule{\linewidth}{\g_ptxcd_titlerule_dim}
            \par
        }
        \endgroup
        \vskip 2em
        \ConfigureHeadline{}
    }%
}{
    \IfTudaciVersionBetweenTF{2.10}{2.11}{
        \renewcommand*{\@maketitle}{%
            \global\@topnum=\z@
            \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
            \vspace*{-\dim_eval:n {
                    \headheight
                    -\c_TUDa_largerule_dim -\c_TUDa_rulesep_dim
                    +\headsep
                    +\ht\strutbox
                    +\p@
                }}
            \par
            \nointerlineskip
            \raisebox{\dim_eval:n {
                    -.5\c_TUDa_logoheight_dim
                }}[0pt][\dim_eval:n {\bool_if:NTF \g_TUDa_smalltitle_bool {.25} {.5}\c_TUDa_logoheight_dim}]{
                \bool_if:NT \g_TUDa_colorback_bool {\color{accentcolor}\rule{\linewidth}{.5\c_TUDa_logoheight_dim}}
            }
            \par\nointerlineskip
            \begingroup
            \setlength{\fboxsep}{\z@}
            \bool_if:NT \g_TUDa_colorback_bool {\colorbox{accentcolor}}{\parbox[t]{\linewidth}{
                    \raisebox{-\height}{%
                        \begin{minipage}[t]{\dimexpr\linewidth-2.2\c_TUDa_logoheight_dim-1ex}
                            \bool_if:NT \g_TUDa_colorback_bool  {\begin{addmargin}{3mm}}
                                    \raggedright
                                    \bool_if:NT \g_TUDa_colorback_bool {\color{textonaccentcolor}}
                                    \tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
                                    \leavevmode\usekomafont{title}%
                                    {\usekomafont{title}\bool_if:NTF \g_TUDa_smalltitle_bool {\LARGE} {\huge} {\@title\par}}%
                                    \vskip 1em
                                    \bool_if:NF \g_TUDa_ex_compatibility_bool
                                    {
                                        {\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
                                        \gdef\@subtitle{}
                                        \vskip .5em
                                    }
                                    % {\ifx\@author\@empty\else\usekomafont{author}\@author\par\fi}%
                                    \vskip .5em
                                    \bool_if:NTF \g_TUDa_colorback_bool {\end{addmargin}} {\par}
                        \end{minipage}}
                    \tl_if_empty:NF \g_TUDa_logofile_tl {
                        \hfill\raisebox{\dim_eval:n {
                                \bool_if:NTF \g_TUDa_colorback_bool
                                {-\height}
                                {-.9\c_TUDa_logoheight_dim}
                            }}
                        [0pt]
                        [\dim_eval:n {
                                \bool_if:NTF \g_TUDa_smalltitle_bool
                                {\bool_if:NTF \g_TUDa_colorback_bool {1.15}{1}}
                                {\bool_if:NTF \g_TUDa_colorback_bool {1.5}{1.3}
                                }\c_TUDa_logoheight_dim}]
                        {\makebox[2.2\c_TUDa_logoheight_dim][l]{\includegraphics[height=\c_TUDa_logoheight_dim]{\g_TUDa_logofile_tl}}}
                    }
                    \par\medskip
                }}
            \par
            \nointerlineskip
            \rule{\linewidth}{\g_TUDa_titlerule_dim}
            % subtitle fields if not compat
            \exp_args:Nf \tl_if_empty:nF {\seq_use:Nnnn \g_TUDa_author_seq {~\authorandname{}~} {,~} {~\&~}\seq_use:Nnnn \g_ptxcd_contributor_seq {~\authorandname{}~} {,~} {~\authorandname{}~}\g_TUDa_ex_sheetnum_tl\@date\g_TUDa_ex_term_tl\use:c {@subsubtitle}\@subtitle}{
                \par\nointerlineskip
                \bool_if:NT \g_TUDa_colorback_bool {\colorbox{accentcolor}}{
                    \parbox{\linewidth}{
                        \begin{minipage}{\linewidth}
                            \bool_if:NT \g_TUDa_colorback_bool {
                                \color{textonaccentcolor}
                                \begin{addmargin}{3mm}
                                    }
                                    \null\par
                                    % Term
                                    \bool_if:NTF \g_manual_term_bool{
                                        \g_TUDa_ex_term_tl
                                    }
                                    {
                                        \def\ptxcd_nextsep{}
                                        \bool_gset_true:N \g_tmpa_left_bool
                                        \clist_map_inline:Nn \g_TUDa_ex_term_tl {
                                            % Process different term Styles
                                            \str_case_e:nnF {\g_ptxcd_ex_term_style_tl} {
                                                {left} {
                                                    \tl_if_empty:cF {##1} {
                                                        \seq_put_right:cn {\bool_if:nTF \g_tmpa_left_bool {g_ptxcd_term_left_seq} {g_ptxcd_term_right_seq}} {\use:c {##1}}
                                                    }
                                                }
                                                {center} {
                                                    \tl_if_empty:cF {##1} {
                                                        \seq_put_right:cn {\bool_if:nTF \g_tmpa_left_bool {g_ptxcd_term_left_seq} {g_ptxcd_term_right_seq}} {\use:c {##1}}
                                                    }
                                                }
                                                {left-right} {
                                                    \tl_if_empty:cF {##1} {
                                                        \seq_put_right:cn {\bool_if:nTF \g_tmpa_left_bool {g_ptxcd_term_left_seq} {g_ptxcd_term_right_seq}} {\use:c {##1}}\bool_set:Nn \g_tmpa_left_bool {!\g_tmpa_left_bool}
                                                    }
                                                }
                                                {left-right-manual} {
                                                    % Do Nothing lol
                                                }
                                            }
                                            {
                                                \ClassError{rubos_tuda_template}{Unknown Term style Option: \use:c {\g_ptxcd_ex_term_style_tl}}{Available options are: left, center, left-right (default)}
                                            }
                                        }
                                        % Left Side
                                        \begin{minipage}[t]{\seq_if_empty:NF {\g_ptxcd_term_right_seq}{.6}\linewidth}
                                            \str_if_eq:eeT{\g_ptxcd_ex_term_style_tl} {center} {\centering}
                                            \seq_use:Nnnn \g_ptxcd_term_left_seq {\mbox{}\\} {\mbox{}\\} {\mbox{}\\}
                                            \gdef\ptxcd_nextsep{\\}
                                        \end{minipage}
                                        \seq_if_empty:NF {\g_ptxcd_term_right_seq}{
                                            \begin{minipage}[t]{.4\linewidth}
                                                \raggedleft
                                                \begin{flushright}
                                                    \seq_use:Nnnn \g_ptxcd_term_right_seq {\mbox{}\\} {\mbox{}\\} {\mbox{}\\}
                                                \end{flushright}
                                                \gdef\ptxcd_nextsep{\\}
                                            \end{minipage}
                                            \tl_if_empty:NF \g_TUDa_ex_term_tl {\ptxcd_nextsep\g_TUDa_ex_term_tl}
                                        }
                                        % \clist_map_inline:nn {@subtitle, @subsubtitle, g_ptxcd_ex_term_tl} {
                                        %   \tl_if_empty:cF {##1} {\ptxcd_nextsep\use:c {##1}\def\ptxcd_nextsep{\\}}
                                        % }
                                        % \tl_if_empty:NF \g_TUDa_ex_sheetnum_tl {\ptxcd_nextsep\sheetname\sheetsep\g_TUDa_ex_sheetnum_tl}
                                    }
                                    \bool_if:NT \g_TUDa_colorback_bool {\end{addmargin}}
                        \end{minipage}
                        \vspace*{\dp\strutbox}
                    }}\par\nointerlineskip
                \rule{\linewidth}{\g_TUDa_titlerule_dim}
            }
            \par
            \bool_if:NT  \g_TUDa_headontitle_bool {
                \if@twoside
                    \box_use:N \g_TUDa_ex_headline_odd_box
                \else
                    \box_use:N \g_TUDa_ex_headline_oneside_box
                \fi
                \par
                \rule{\linewidth}{\g_TUDa_titlerule_dim}
                \par
            }
            \endgroup
            \vskip 2em
            \ConfigureHeadline{}
        }%
    }{
        \ClassError{rubos-tuda-template}{Tu-Template~Version~zu~alt.}{Bitte~die~neuste~tuda-ci~Version~installieren.}
    }

}


% Better Task Titles
\IfTudaciVersionAtLeastTF{3.13}{
    \renewcommand*\sectionlinesformat[4]{%
        \parbox{\linewidth}{
            \bool_if:cT {g__ptxcd_ruled_#1_bool} {
                \rule[5\g_ptxcd_titlerule_dim]{\linewidth}{\g_ptxcd_titlerule_dim}\par\nointerlineskip
            }
            \@hangfrom{%
                \hskip #2#3}{
                \tl_if_eq:nnT {#1} {task} {
                    \exp_args:No \tl_if_empty:nF {#4}
                    {:~}
                    \bool_if:NT \l__ptxcd_points_auto_bool {
                        \exp_args:NNx \prop_get:NnN \g__ptxcd_loaded_points_prop {\thetask} \l_ptxcd_tmp_tl
                        \quark_if_no_value:NF \l_ptxcd_tmp_tl {
                            \fp_set:Nn \l_ptxcd_ex_task_points_fp {\l_ptxcd_tmp_tl}
                        }
                    }
                }
                {#4\ensuremath{\vcenter{\hbox{\tikz{\node[inner~sep=0pt, text~height=1.1em]{};}}}}}% Übungstitel mit Seriefen
                \tl_if_in:nnT {#1} {task} {
                    \tl_if_empty:cTF{l_ptxcd_ex_#1_credit_tl}
                    {\pointformat{\fp_to_decimal:c {l_ptxcd_ex_#1_points_fp}}}
                    {\creditformat{\tl_use:c {l_ptxcd_ex_#1_credit_tl}}}
                }
                \rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par}\nointerlineskip
            \skip_vertical:n {\ptxcd_titlerule_sep: -\dp\strutbox}
            \bool_if:cT {g__ptxcd_ruled_#1_bool} {\smash{\rule{\linewidth}{\g_ptxcd_titlerule_dim}}}
        }}
}{}


\newcommand*{\numberFormBox}[1]{
    \rule{\fboxrule}{1ex}
    \tikz[overlay,baseline=.1ex,anchor=south~west]{\node[inner~sep=0pt, minimum~size=1em] at(0,0){#1};}
    \rule{1em}{\fboxrule}
    \rule{\fboxrule}{1ex}
    \,
}

% Custom Headline Style
\clist_map_inline:nn {odd, even, oneside} {
    \keys_define:nn {ptxcd/exercise/headline} {
        #1 .choice:,
        #1 / aud .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {
            \textbf{\g_ptxcd_shorttitle_tl}
            \tl_if_empty:NF \g_rubos_document_semester_tl {\space{}im\space\textbf{\g_rubos_document_semester_tl}}
            \tl_if_empty:NF \g_rubos_document_dozent_tl {\space{}bei\space\textbf{\g_rubos_document_dozent_tl}}
            \tl_if_empty:NF \g_ptxcd_ex_sheetnum_tl {\hfill Übungsblatt\space{}\padzeroes[2]{\g_ptxcd_ex_sheetnum_tl}}
            \par
            \StudentNamename
            \StudentNamesep
            \IfSolutionT{
                \rlap{\textbf{\textsf{~Musterlösung}}}
            }
            \hrulefill\qquad
            \StudentIDname
            \StudentIDsep
            \prg_replicate:nn {7} {
                \numberFormBox{\IfSolutionT{\textbf{\textsf{0}}}}
            }
        },
        #1 / submittors-detailed .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} { % Diese Option ist eher für Einzelabgaben gedacht, da sie sonst sehr viel Platz weg nimmt
            \textbf{\g_ptxcd_shorttitle_tl}
            \tl_if_empty:NF \g_rubos_document_semester_tl {\space{}im\space\textbf{\g_rubos_document_semester_tl}}
            \tl_if_empty:NF \g_rubos_document_dozent_tl {\space{}bei\space\textbf{\g_rubos_document_dozent_tl}}
            \tl_if_empty:NF \g_ptxcd_ex_sheetnum_tl {\hfill Übungsblatt\space{}\padzeroes[2]{\g_ptxcd_ex_sheetnum_tl}}
            \par
            \gdef\ptxcd_nextsep_submittors{}
            \seq_map_inline:Nn \g_ptxcd_submittors_seq {
                \ptxcd_nextsep_submittors
                \StudentNamename
                \StudentNamesep
                \rlap{\textbf{\textsf{~####1}}}
                \hrulefill\qquad
                \StudentIDname
                \StudentIDsep
                \exp_args:Nx\str_map_inline:Nn {\getMatrikelnummer{####1}} {\textbf{\textsf{\numberFormBox{########1}}}}
                \gdef\ptxcd_nextsep_submittors{\par}
            }
        },
        #1 / submittors-semi-detailed .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} { % Diese Option ist eher für Einzelabgaben gedacht, da sie sonst sehr viel Platz weg nimmt
            \textbf{\g_ptxcd_shorttitle_tl}
            \tl_if_empty:NF \g_rubos_document_semester_tl {\space{}im\space\textbf{\g_rubos_document_semester_tl}}
            \tl_if_empty:NF \g_rubos_document_dozent_tl {\space{}bei\space\textbf{\g_rubos_document_dozent_tl}}
            \tl_if_empty:NF \g_ptxcd_ex_sheetnum_tl {\hfill Übungsblatt\space{}\padzeroes[2]{\g_ptxcd_ex_sheetnum_tl}}
            \par
            \seq_if_empty:NF\g_ptxcd_submittors_seq {
                \textbf{Abgabe\space{}von:}\space
                \seq_use:Nnnn \g_ptxcd_submittors_seq {~\authorandname{}~} {,~} {~\authorandname{}~}
            }
        },
        #1 / submittors .code:n = {
            \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {
                \textbf{\textsf{\g_ptxcd_shorttitle_tl\space{}Abgabe}}
                \seq_if_empty:NF \g_ptxcd_submittors_seq {
                    \textbf{\textsf{\space{}von:}}\space
                    \seq_use:Nnnn \g_ptxcd_submittors_seq {~\authorandname{}~} {,~} {~\authorandname{}~}
                }
            }
        },
        #1 / submittors-centered .code:n = {
            \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {
                \centering\textbf{\textsf{\g_ptxcd_shorttitle_tl\space{}Abgabe}}
                \seq_if_empty:NF\g_ptxcd_submittors_seq {
                    \textbf{\textsf{\space{}von:}}\space
                    \seq_use:Nnnn \g_ptxcd_submittors_seq {~\authorandname{}~} {,~} {~\authorandname{}~}
                }
            }
        },
        #1 / summary-centered .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {%
            \centering
            \textbf{\sffamily\g_ptxcd_shorttitle_tl\space{}Zusammenfassung}
            \space{}von\space{}
            \seq_use:Nnnn \g_ptxcd_author_seq {~\authorandname{}~} {,~} {~\authorandname{}~}
        },
        #1 / unknown .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {##1}
    }
}
\clist_map_inline:nn {odd, even, oneside} {
    \keys_define:nn {TUDa/exercise/headline} {
        #1 .choice:,
        #1 / aud .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {
            \textbf{\g_TUDa_shorttitle_tl}
            \tl_if_empty:NF \g_rubos_document_semester_tl {\space{}im\space\textbf{\g_rubos_document_semester_tl}}
            \tl_if_empty:NF \g_rubos_document_dozent_tl {\space{}bei\space\textbf{\g_rubos_document_dozent_tl}}
            \tl_if_empty:NF \g_TUDa_ex_sheetnum_tl {\hfill Übungsblatt\space{}\padzeroes[2]{\g_TUDa_ex_sheetnum_tl}}
            \par
            \StudentName
            \StudentID
        },
        #1 / submittors-detailed .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} { % Diese Option ist eher für Einzelabgaben gedacht, da sie sonst sehr viel Platz weg nimmt
            \textbf{\g_TUDa_shorttitle_tl}
            \tl_if_empty:NF \g_rubos_document_semester_tl {\space{}im\space\textbf{\g_rubos_document_semester_tl}}
            \tl_if_empty:NF \g_rubos_document_dozent_tl {\space{}bei\space\textbf{\g_rubos_document_dozent_tl}}
            \hfill Übungsblatt\space{}\padzeroes[2]{\g_TUDa_ex_sheetnum_tl}
            \par
            \gdef\ptxcd_nextsep_submittors{}
            \seq_map_inline:Nn \g_ptxcd_submittors_seq {
                \ptxcd_nextsep_submittors
                Name
                \StudentNamesep
                \hrulefill ####1\hrulefill
                \qquad
                \StudentIDname
                \StudentIDsep
                \exp_args:Nx\str_map_inline:Nn {\getMatrikelnummer{####1}} {\numberFormBox{########1}}
                \gdef\ptxcd_nextsep_submittors{\par}
            }
        },
        #1 / submittors-semi-detailed .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} { % Diese Option ist eher für Einzelabgaben gedacht, da sie sonst sehr viel Platz weg nimmt
            \textbf{\g_TUDa_shorttitle_tl}
            \tl_if_empty:NF \g_rubos_document_semester_tl {\space{}im\space\textbf{\g_rubos_document_semester_tl}}
            \tl_if_empty:NF \g_rubos_document_dozent_tl {\space{}bei\space\textbf{\g_rubos_document_dozent_tl}}
            \hfill Übungsblatt\space{}\padzeroes[2]{\g_TUDa_ex_sheetnum_tl}
            \par
            \seq_if_empty:NF\g_ptxcd_submittors_seq {
                \textbf{Abgabe\space{}von:}\space
                \seq_use:Nnnn \g_ptxcd_submittors_seq {~\authorandname{}~} {,~} {~\authorandname{}~}
            }
        },
        #1 / submittors .code:n = {\tl_gset:cn {g_TUDa_ex_headline_#1_tl} {
                \textbf{\textsf{\g_TUDa_shorttitle_tl\space{}Abgabe}}
                \seq_if_empty:NF\g_ptxcd_submittors_seq {
                    \textbf{\textsf{\space{}von:}}\space
                    \seq_use:Nnnn \g_ptxcd_submittors_seq {~\authorandname{}~} {,~} {~\authorandname{}~}
                }
            }
        },
        #1 / submittors-centered .code:n = {
            \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {
                \centering\textbf{\textsf{\g_TUDa_shorttitle_tl\space{}Abgabe}}
                \seq_if_empty:NF\g_ptxcd_submittors_seq {
                    \textbf{\textsf{\space{}von:}}\space
                    \seq_use:Nnnn \g_ptxcd_submittors_seq {~\authorandname{}~} {,~} {~\authorandname{}~}
                }
            }
        },
        #1 / summary-centered .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {%
            \centering\textbf{\sffamily\g_TUDa_shorttitle_tl\space{}Zusammenfassung}
            \space{}von\space{}
            \seq_use:Nnnn \g_TUDa_author_seq {~\authorandname{}~} {,~} {~\authorandname{}~}
        },
        #1 / unknown .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {##1}
    }
}

% --Makros--
% \newcommand{\code}[2][java]{\mintinline{#1}{#2}}

\newcommand{\refexercise}[1]{
    \int_gzero_new:N \g_ptxcd_tmp_int
    \int_gset:Nn \g_ptxcd_tmp_int {\value{task}}
    \setcounter{task}{\getrefnumber{#1}}
    \hyperref[#1]{\taskformat}
    \setcounter{task}{\int_use:N \g_ptxcd_tmp_int}
}
