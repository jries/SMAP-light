classdef DisplayChooser<interfaces.WorkflowModule
%     Select which image to display during preview.
    properties
        filterkernel
    end
    methods
        function obj=DisplayChooser(varargin)
            obj@interfaces.WorkflowModule(varargin{:});
            obj.outputParameters={'loc_previewmode'};
            obj.inputChannels=0;
        end
        function pard=guidef(obj)
            pard=guidef;
        end
        function initGui(obj)
            initGui@interfaces.WorkflowModule(obj);
        end
    end
end


function pard=guidef
pard.text.object=struct('Style','text','String','preview mode: ');
pard.text.position=[1,1];
pard.text.Width=1.1;
pard.loc_previewmode.object=struct('Style','popupmenu','String','image-bg|image|norm(image)|bg');
pard.loc_previewmode.position=[1,2];
pard.loc_previewmode.Width=1.0;
pard.loc_previewmode.TooltipString=sprintf('Determine which image to display in Preview mode. Peak finding is performed on norm(image)');
pard.plugininfo.type='WorkflowModule';
pard.plugininfo.description='Select which image to display during preview.';
end