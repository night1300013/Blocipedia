class CollaboratorsController < ApplicationController
  # before_action :set_wiki
  # def new
  #   @collaborator = @wiki.collaborators.new
  # end
  #
  # def create
  #   @collaborator = @wiki.collaborators.build(collaborator_params)
  #
  #   if @collaborator.save
  #     flash[:notice] = "Collaborator was saved."
  #   else
  #     flash[:alert] = "There was an error saving collaborator."
  #   end
  #     redirect_to @wiki
  # end
  #
  # def destroy
  #   @collaborator = Collaborator.find(params[:id])
  #
  #   if @collaborator.destroy
  #     flash[:notice] = "collaborator was successfully removed."
  #   else
  #     flash[:alert] = "There was an error deleting collaborator"
  #   end
  #     redirect_to @wiki
  # end
  #
  # private
  #
  # def set_wiki
  #   @wiki = Wiki.find(params[:wiki_id])
  # end
  #
  # def collaboration_params
  #   params.require(:collaborator).permit(:wiki_id, :user_id)
  # end
end
