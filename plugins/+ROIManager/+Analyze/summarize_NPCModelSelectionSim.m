classdef summarize_NPCModelSelectionSim<interfaces.DialogProcessor&interfaces.SEProcessor
    methods
        function obj=summarize_NPCModelSelectionSim(varargin)        
                obj@interfaces.DialogProcessor(varargin{:});
            obj.inputParameters={'se_viewer', 'se_siteroi', 'se_sitefov'};
            obj.showresults=true;
        end
        
        function out=run(obj,p)
            se = obj.locData.SE;
            sites = se.sites;

            lUsed = getFieldAsVector(sites, 'annotation.use');
            siteOrder = 1:se.numberOfSites;

           
            for k = se.numberOfSites:-1:1
                sym(k) = se.sites(k).evaluation.simulatesites.model.model{1}.modelObj.internalSettings.cornerNum;
            end

            LLfit = [];
            
            for m = 1:5
                LLfit.(['sym',num2str(m+5),'f']) = getFieldAsVector(sites, ['evaluation.SMLMModelFitGUI_' num2str(m+2) '.fitInfo.LLfit']);
            end
            
            allSym = unique(sym);
            for d = 1:length(allSym)
                ax = obj.initaxis(['data_sym',num2str(d+5),'f']);
                lOneSym = sym == allSym(d);
                axes(ax)
                hold on
                for m = 1:5
                    LLfit_oneModel = LLfit.(['sym',num2str(m+5),'f'])(lOneSym);
                    cdfplot(LLfit_oneModel)
                end
                legend({'6-fold','7-fold','8-fold','9-fold','10-fold'})
                hold off
            end
        out = [];    
        end
        function pard=guidef(obj)
            pard=guidef(obj);
        end
    end
end

function recover_callback(a,b,obj)
    % get the pos from the backup
    obj.locData.loc.xnm = obj.locData.loc.xnmori;
    obj.locData.loc.ynm = obj.locData.loc.ynmori;
end

function rank_callback(a,b,obj)
    % get the pos from the backup
    fn = fieldnames(obj.locData.loc);
    a.String = fn';
    a.Enable = 'on';
end


function pard=guidef(obj)

pard.showIntActPlot.object=struct('String','Display interactive','Style','checkbox');
pard.showIntActPlot.position=[2,1];
pard.showIntActPlot.Width=1.5;

pard.showExampleMod.object=struct('String','Display example model','Style','checkbox');
pard.showExampleMod.position=[3,1];
pard.showExampleMod.Width=1.5;

pard.plugininfo.type='ROI_Analyze';

end